Received: from eggs.gnu.org ([2001:4830:134:3::10]:43923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5V5-0001CE-FH
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5V2-00038W-Bg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5V2-00038E-6a
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:53:36 -0400
References: <20180430062536.49077-1-aik@ozlabs.ru>
	<20180430062536.49077-2-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00093926-1d43-0213-34ba-68f72e4057ac@redhat.com>
Date: Mon, 30 Apr 2018 11:53:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180430062536.49077-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v2 1/2] memory/hmp: Print
 owners/parents in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 30/04/2018 08:25, Alexey Kardashevskiy wrote:
> +    DeviceState *dev =3D (DeviceState *) object_dynamic_cast(obj, TYPE=
_DEVICE);
> +    const char *id =3D object_property_print(obj, "id", true, NULL);

The only objects that have an "id" property are memdevs.  If you want to
special case their printing too, it's probably a good idea (that is,
print one of "dev id=3DID"/"memdev id=3DID"/"obj path=3DPATH").

Otherwise, I can also queue this patch as is, but I'd remove the "id"
property handling because I'm going to submit a small series to remove
the "id" property altogether.

Let me know what you prefer!

Thanks,

Paolo

> +    mon_printf(f, " %s:{%s", label, dev ? "dev" : "obj");
> +    if (dev ? dev->id : id) {
> +        mon_printf(f, " id=3D%s", dev ? dev->id : id);
> +    } else {
> +        gchar *canonical_path =3D object_get_canonical_path(obj);
> +        mon_printf(f, " path=3D%s", canonical_path);
> +        g_free(canonical_path);
> +    }
> +    mon_printf(f, "}");

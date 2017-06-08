Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0TH-0002Vc-IR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0TE-00033X-9m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ0TE-00032R-3V
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 158EC78EC7
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:39:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-19-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 18:39:33 +0200
In-Reply-To: <20170607163635.17635-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:10 +0400")
Message-ID: <87r2yu4enu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 18/43] apic-common: make "id" property a
 uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The getter and setter of TYPE_APIC_COMMON property "id" are
> apic_common_get_id() and apic_common_set_id().
>
> apic_common_get_id() reads either APICCommonState member uint32_t
> initial_apic_id or uint8_t id into an int64_t local variable.  It then
> passes this variable to visit_type_int().
>
> apic_common_set_id() uses visit_type_int() to read the value into a
> local variable, which it then assigns both to initial_apic_id and id.
>
> While the state backing the property is two unsigned members, 8 and 32
> bits wide, the actual visitor is 64 bits signed.
>
> Change getter and setter to use visit_type_uint32().  Then everything's
> uint32_t, except for @id.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

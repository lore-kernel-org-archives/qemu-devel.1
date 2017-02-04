Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx7H-000818-Ic
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx7C-0002H5-J9
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:58:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cZx7C-0002Gx-DJ
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:58:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170202171625.28502-1-rjones@redhat.com>
	<20170202171625.28502-2-rjones@redhat.com>
	<20170203151643.GG642@stefanha-x1.localdomain>
	<20170203165209.GZ15182@redhat.com>
Date: Sat, 04 Feb 2017 10:58:39 +0100
In-Reply-To: <20170203165209.GZ15182@redhat.com> (Richard W. M. Jones's
	message of "Fri, 3 Feb 2017 16:52:09 +0000")
Message-ID: <87inoq6zw0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org, pbonzini@redhat.com

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Fri, Feb 03, 2017 at 03:16:43PM +0000, Stefan Hajnoczi wrote:
>> On Thu, Feb 02, 2017 at 05:16:25PM +0000, Richard W.M. Jones wrote:
>> > +    if (*port == NULL) {
>> > +        *port = g_strdup_printf("%d", NBD_DEFAULT_PORT);;
>> 
>> Please stringify NBD_DEFAULT_PORT instead of using g_strdup_printf().
>> That avoids the memory leak.
>
> Oops.
>
> Do we have a macro for this already?  I couldn't see one, and the
> best I could come up with is:
>
> #define MACRO_EXPAND_STRINGIFY(x) STRINGIFY(x)
> #define STRINGIFY(x) #x

Check out stringify() in compiler.h.

(Yes, lower-case macros that don't behave like functions are bad style)

[...]

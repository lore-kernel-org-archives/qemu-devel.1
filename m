Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dp8fu-0006Tx-Dh
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dp8fp-00007J-Sc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dp8fp-0008WQ-Mm
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:53:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com>
Date: Tue, 05 Sep 2017 09:53:24 +0200
In-Reply-To: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com> (Thiago Jung
	Bauermann's message of "Fri, 18 Aug 2017 14:46:14 -0300")
Message-ID: <87r2vl37kb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] .dir-locals.el: Explicitly set indentation
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> At least in some configurations, setting c-file-style is not enough to
> conform to the QEMU coding style, so explicitly set c-basic-offset as well.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>
> My emacs was using indentation level of 8 spaces and this patch convinced
> it to use the correct value.
>
> I set c-basic-offset set to tab-width in my ~/.spacemacs which perhaps
> isn't the wisest thing to do, but since there's a .dir-locals.el we can
> make the editor always do the right thing.

I think some of this rationale should be worked into the commit message
if we decide the patch makes sense.

>  .dir-locals.el | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> index 3ac0cfc6f0d6..8e47418c5996 100644
> --- a/.dir-locals.el
> +++ b/.dir-locals.el
> @@ -1,2 +1,3 @@
>  ((c-mode . ((c-file-style . "stroustrup")
> -	    (indent-tabs-mode . nil))))
> +	    (indent-tabs-mode . nil)
> +	    (c-basic-offset . 4))))

Style "stroustrup" already specified c-basic-offset 4.  If we need to
specify this setting a second time, why don't we need to specify the
style's other settings a second time, too?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRcdd-0007y0-3S
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRcdZ-0008H0-20
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:38:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRcdY-0008FL-MW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:38:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
	<1543312923-3074-3-git-send-email-liq3ea@gmail.com>
	<20181127102736.q2322bc6uw4wvvif@starbug-mbp.local>
Date: Tue, 27 Nov 2018 13:38:35 +0100
In-Reply-To: <20181127102736.q2322bc6uw4wvvif@starbug-mbp.local> (Darren
	Kenny's message of "Tue, 27 Nov 2018 10:27:36 +0000")
Message-ID: <87a7lur8z8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw: vmmouse: drop DEFINE_PROP_PTR()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org

Darren Kenny <darren.kenny@oracle.com> writes:

> Hi Li Qiang,
>
> This is only a suggestion, I'm sure someone else might also correct
> me, but I'm not sure the subject above really describes what is
> happening in the commit as a whole.
>
> It seems to miss the point that the main change here is to use a
> link type property, so maybe it might be better written as something
> along the lines of:
>
>  Subject: [PATCH v2 2/2] hw: vmmouse: use link property instead of pointer
>  Drop DEFINE_PROP_PTR() and replace with a link pointer via an
>  instance init function (vmmouse_instance_initfn).

Yes, that's better.  Or take inspiration from recent similar work, such
as commit a8299ec1b24, and say something like

    vmmouse: Use link instead of pointer property

    According to qdev-properties.h, properties of pointer type should
    be avoided.  Turn "ps2_mouse" into a link.

Preferably with the commit message improved along these lines:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]

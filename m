Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXLQr-00034J-M3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXLQo-0006Dv-Hk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:57:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXLQo-0006Di-Cr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2A1D4000B8A
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 06:56:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1529550907-26824-1-git-send-email-thuth@redhat.com>
Date: Mon, 25 Jun 2018 08:56:56 +0200
In-Reply-To: <1529550907-26824-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 21 Jun 2018 05:15:07 +0200")
Message-ID: <87efgvxsjr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> The oldest machine type which is still used in a still maintained distro
> is a pc-0.12 based machine type in RHEL6, so everything that is older
> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> and pc-0.11 so that we can finally remove them in a future release.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

    $ qemu-system-x86_64 -M pc-0.10
    qemu-system-x86_64: Machine type 'pc-0.10' is deprecated: Old and unsupported machine version, use a newer machine type instead.

Please drop the period.

"Old and unsupported" feels redundant after "is deprecated".  What about

    qemu-system-x86_64: Machine type 'pc-0.10' is deprecated, use a newer version of the machine type instead

or even

    qemu-system-x86_64: Machine type 'pc-0.10' is deprecated, use a newer machine type instead

?

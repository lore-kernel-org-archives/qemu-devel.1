Received: from eggs.gnu.org ([2001:4830:134:3::10]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ6K-00077N-L9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ6J-000715-TS
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQ6J-00070c-OX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:10:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 575EA8076894
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:10:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533203376-25621-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 2 Aug 2018 11:49:36 +0200")
References: <1533203376-25621-1-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:10:49 +0200
Message-ID: <87zhxe4spi.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/migration-test: Turn kvm_hv message
 into a g_debug message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> When running "make check" on a non-POWER host, there is currently an ugly
> line in the output like this:
>
>   [...]
>   GTESTER check-qtest-nios2
>   GTESTER check-qtest-or1k
>   GTESTER check-qtest-ppc64
> Skipping test: kvm_hv not available Skipping test: kvm_hv not available Skipping test: kvm_hv not available Skipping test: kvm_hv not available   GTESTER check-qtest-ppcemb
>   GTESTER check-qtest-ppc
>   GTESTER check-qtest-riscv32
>   GTESTER check-qtest-riscv64
>   [...]
>
> Move the check to the beginning of the main function instead, so that
> we do not have to test the condition again and again for each test,
> and better use g_test_message() instead of g_print() here, like it is
> also done in ufd_version_check() already.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

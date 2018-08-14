Received: from eggs.gnu.org ([2001:4830:134:3::10]:39815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdGs-0008L7-8U
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdGc-0004qe-VM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:38:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdGc-0004qa-Q1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:38:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-2-git-send-email-thuth@redhat.com>
Date: Tue, 14 Aug 2018 19:37:59 +0200
In-Reply-To: <1534258018-22859-2-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Tue, 14 Aug 2018 16:46:53 +0200")
Message-ID: <87a7posvbc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/migration-test: Silence the
 kvm_hv message by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> When running "make check" on a non-POWER host, the output is quite
> distorted like this:
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOMAC-0000iH-SO
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOMA7-00011m-Uw
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:17:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOMA7-00011c-OW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:17:47 -0500
Date: Tue, 3 Jan 2017 18:17:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170103101742.GH22664@pxdev.xzpeter.org>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
	<1483438205-31110-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483438205-31110-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Tue, Jan 03, 2017 at 06:10:05PM +0800, Peter Xu wrote:

[...]

> diff --git a/scripts/global.bash b/scripts/global.bash
> index 77b0b29..52095bd 100644
> --- a/scripts/global.bash
> +++ b/scripts/global.bash
> @@ -1,2 +1,13 @@
>  : ${ut_log_dir:=logs}
>  : ${ut_log_summary:=${ut_log_dir}/SUMMARY}
> +: ${ut_run_queues:=1}
> +
> +function ut_in_parallel()
> +{
> +    [[ $ut_run_queues != 1 ]]
> +}
> +

This function is useless now. Should remove above five lines. Sorry.

-- peterx

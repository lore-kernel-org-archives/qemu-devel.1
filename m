Received: from eggs.gnu.org ([2001:4830:134:3::10]:58405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHrCx-0001xo-L9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHrCt-0001gA-K6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:10:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHrCs-0001VK-Hj
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:10:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so15298819wmw.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:10:36 -0700 (PDT)
References: <154096215214.6332.16173638540950760088@015909e0f939>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6596f2f5-01f4-6075-48c0-359134856284@redhat.com>
Date: Wed, 31 Oct 2018 15:10:32 +0100
MIME-Version: 1.0
In-Reply-To: <154096215214.6332.16173638540950760088@015909e0f939>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: ppandit@redhat.com, famz@redhat.com

Hi Gerd,

On 31/10/18 6:02, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: fmops: fix off-by-one in AR_TABLE and DR_TABLE array size...
> ERROR: code indent should never use tabs
> #27: FILE: hw/audio/fmopl.h:75:
> +^Iint32_t AR_TABLE[76];^I/* atttack rate tables */$

Can you also fix "attack" when respinning?

> 
> ERROR: code indent should never use tabs
> #28: FILE: hw/audio/fmopl.h:76:
> +^Iint32_t DR_TABLE[76];^I/* decay rate tables   */$
> 
> total: 2 errors, 0 warnings, 10 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===

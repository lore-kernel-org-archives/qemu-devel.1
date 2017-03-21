Received: from eggs.gnu.org ([2001:4830:134:3::10]:59354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqO68-0005sE-5H
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqO67-0006HY-C7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:01:32 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqO67-0006HK-51
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:01:31 -0400
Received: by mail-wr0-x22d.google.com with SMTP id g10so116946301wrg.2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 11:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <472e433e-8cd7-4762-c102-bf7a4ca91afc@redhat.com>
References: <1490106717-9542-1-git-send-email-peter.maydell@linaro.org>
	<472e433e-8cd7-4762-c102-bf7a4ca91afc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 18:01:09 +0000
Message-ID: <CAFEAcA_wf7Y==ADgk0bqA6O9EeOTotH_JEnhFmBs=CKdgbLPJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 March 2017 at 17:55, Thomas Huth <thuth@redhat.com> wrote:
> On 21.03.2017 15:31, Peter Maydell wrote:
>> +if test "$supported_os" = "no"; then
>> +    echo
>> +    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
>> +    echo
>> +    echo "CPU host OS $targetos support is not currently maintained."
>
> Maybe rather just "Host OS" instead of "CPU host OS" ?
>
>> +    echo "The QEMU project intends to remove support for this host CPU in"
>
> At least here I think you should replace "host CPU" with "host OS". With
> that modification:

Mmm, yes, those are both cut-n-paste errors from the CPU warning text.
Unfortunately this commit is already in master because I wanted to get
it into rc1 today. I'll send a separate patch that fixes these.

thanks
-- PMM

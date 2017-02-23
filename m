Received: from eggs.gnu.org ([2001:4830:134:3::10]:49525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch06u-0003F5-Lt
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch06p-0003m3-PR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:35:32 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ch06p-0003lq-Kl
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:35:27 -0500
Received: by mail-qt0-x241.google.com with SMTP id n37so313535qtb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 12:35:27 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170223182927.7166-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fd54d371-fdc2-5eb7-ac94-5817cf7a4eb5@twiddle.net>
Date: Fri, 24 Feb 2017 07:35:17 +1100
MIME-Version: 1.0
In-Reply-To: <20170223182927.7166-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org

On 02/24/2017 05:29 AM, Alex Bennée wrote:
> Hi Richard/Peter,
>
> Well obviously it was expecting a bit much for v13 to pass with flying
> colours. A merge failure which didn't affect ARM caused the
> regressions on other platforms resulting in the iothread not being
> released during cpu_handle_interrupt. This fix has been merged into
> Jan's drop global lock patch. I also fixed a whitespace issue on the
> error_report/printf for the memory order check.

LGTM.  I've re-tested with Alpha and everything seems to be ok.
You've got all of my R-B already.

> So if you are happy are you going to be able to submit the pull
> request before the soft-freeze kicks in?

Are you looking for someone else to sent the pull?  I suspect that Peter and I 
are happy for you to do so.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chA7D-0000vQ-2L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chA79-00030s-4U
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:16:31 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chA78-00030m-UL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 02:16:27 -0500
Received: by mail-wr0-x22f.google.com with SMTP id u47so7318437wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 23:16:26 -0800 (PST)
References: <20170223182927.7166-1-alex.bennee@linaro.org>
	<fd54d371-fdc2-5eb7-ac94-5817cf7a4eb5@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fd54d371-fdc2-5eb7-ac94-5817cf7a4eb5@twiddle.net>
Date: Fri, 24 Feb 2017 07:16:24 +0000
Message-ID: <87wpcgxdmf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org


Richard Henderson <rth@twiddle.net> writes:

> On 02/24/2017 05:29 AM, Alex Bennée wrote:
>> Hi Richard/Peter,
>>
>> Well obviously it was expecting a bit much for v13 to pass with flying
>> colours. A merge failure which didn't affect ARM caused the
>> regressions on other platforms resulting in the iothread not being
>> released during cpu_handle_interrupt. This fix has been merged into
>> Jan's drop global lock patch. I also fixed a whitespace issue on the
>> error_report/printf for the memory order check.
>
> LGTM.  I've re-tested with Alpha and everything seems to be ok.
> You've got all of my R-B already.

Cool.

>> So if you are happy are you going to be able to submit the pull
>> request before the soft-freeze kicks in?
>
> Are you looking for someone else to sent the pull?  I suspect that
> Peter and I are happy for you to do so.

I was following convention:

  "Generally only existing submaintainers of a tree will need to submit
  pull requests, although occasionally for a large patch series we might
  ask a submitter to send a pull request. "

So if Peter is happy I'll send the pullreq today. Peter?

--
Alex Bennée

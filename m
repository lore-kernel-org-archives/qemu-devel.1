Received: from eggs.gnu.org ([2001:4830:134:3::10]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsV9d-0008Mu-PS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsV9c-0003Ov-U9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:30:09 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsV9c-0003NC-NN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:30:08 -0400
Received: by mail-wr0-x22b.google.com with SMTP id z39so489651wrb.8
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5cea7ccd-97b3-ecbf-22c1-72b329c467fc@imgtec.com>
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
	<0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
	<59BA88D1.9080202@ispras.ru>
	<CAFEAcA_HRwa_XFv8M3h_5dK0p6Xiuu1FfF32TPOhEop80wT30A@mail.gmail.com>
	<59BA8F4E.6060600@ispras.ru>
	<5cea7ccd-97b3-ecbf-22c1-72b329c467fc@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 15:29:46 +0100
Message-ID: <CAFEAcA-O9XxpfnQCcg3WFntq4QB=HYjbK-Za4-CCaOtOn=+Nqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Sergey Smolov <smolov@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>

On 14 September 2017 at 15:23, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The reason why your modification is failed is because you passed wrong
> argument. Remember that you are not just calling the helper function from
> translate.c but you are generating some code to let call the helper
> function on run time. You have to create a temporal TCGv to pass the
> register number.
> You could do it like,
> TCGv_i32 tmp = tcg_const_i32(rd)
> gen_helper_trace_reg_access(cpu_env, tmp, cpu_gpr[rs);
> tcg_temp_free_i32(tmp);

Good catch, missed that you need to do that for int
constants...

thanks
-- PMM

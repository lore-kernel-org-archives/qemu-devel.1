Received: from eggs.gnu.org ([2001:4830:134:3::10]:48084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEx9b-0002Iy-BA
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEx9W-0003W8-Ep
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:23:11 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:35781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEx9W-0003VF-5l
	for qemu-devel@nongnu.org; Sat, 05 May 2018 09:23:06 -0400
Received: by mail-lf0-x235.google.com with SMTP id y72-v6so20885240lfd.2
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 06:23:06 -0700 (PDT)
Date: Sat, 5 May 2018 15:23:03 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180505132303.z3hz32trwe5t6ofx@toto>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-23-edgar.iglesias@gmail.com>
	<fc4ccd4e-d0b5-61d9-68ef-fb1feb6c3841@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4ccd4e-d0b5-61d9-68ef-fb1feb6c3841@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 22/29] target-microblaze: Add Extended
 Addressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

On Thu, May 03, 2018 at 12:12:40PM -0700, Richard Henderson wrote:
> On 05/03/2018 02:19 AM, Edgar E. Iglesias wrote:
> > +    trap_userspace(dc, ea);
> 
> Missing if (...) return?

Yup, fixed in v2.

Thanks,
Edgar

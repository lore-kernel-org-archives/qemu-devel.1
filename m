Received: from eggs.gnu.org ([209.51.188.92]:53782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqU1-0001xv-A5
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqTq-0001GZ-Vo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqTn-0001FL-4o
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id l2so5516519plt.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:45:02 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <272feb46-4da7-7834-7a5e-5f54ed416f05@linaro.org>
Date: Wed, 1 May 2019 07:44:58 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 06/15] tests/tcg/multiarch: expand
 system memory test to cover more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> +int do_signed_reads(bool neg_first)
> +{
> +    int r = 0;
> +    int off = 0;
> +
> +    while (r == 0 && off < 8) {
> +        r = read_test_data_s8(off, neg_first ^ (off & 1));
> +        r |= read_test_data_s16(off, !(neg_first ^ (off & 1)));
> +        r |= read_test_data_s32(off, !(neg_first ^ (off & 1)));

You're testing unaligned reads here.

While admirable, and necessary, that's going to limit the number of guests on
which you can run this test.

Do you perhaps want a compiler command-line -DALIGNED_ONLY to control this?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

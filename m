Received: from eggs.gnu.org ([209.51.188.92]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggjVC-0002lp-51
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggjV8-0004Zs-50
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:00:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:35738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggjV5-0004Rl-Oc
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:00:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id p8so1275256plo.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 21:00:27 -0800 (PST)
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-24-richard.henderson@linaro.org>
	<CAFEAcA-Us3KWaLSEkvpg2uE+yvRFbVB=NVemrdhTFfvKxZt3xw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ff1044a-a8d8-75f1-6e37-5149b1cf3dea@linaro.org>
Date: Tue, 8 Jan 2019 15:00:19 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Us3KWaLSEkvpg2uE+yvRFbVB=NVemrdhTFfvKxZt3xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/27] target/arm: Implement
 pauth_computepac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/8/19 12:09 AM, Peter Maydell wrote:
>> +static int rot_cell(int cell, int n)
>> +{
>> +    cell |= cell << 4;
>> +    cell >>= n;
>> +    return cell & 0xf;
> 
> This doesn't seem to do what the RotCell pseudocode does?
> Unless I've made an error, RotCell(ABCD, 1) == BCDA,
> but rot_cell(ABCD, 1) == DABC.

Yep, I mis-read the direction of the rotate.

Thanks for all of the proof-reading.
This section I found particularly eye watering.


r~

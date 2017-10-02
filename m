Received: from eggs.gnu.org ([2001:4830:134:3::10]:57316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz5Ri-0004fV-IQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dz5Rh-0003fM-OU
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:28:02 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:44339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dz5Rh-0003eb-JY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:28:01 -0400
Received: by mail-qt0-x231.google.com with SMTP id y57so3603959qta.1
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 11:28:01 -0700 (PDT)
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-10-richard.henderson@linaro.org>
	<87y3otzk34.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f185d9b4-bd5d-0294-bcfa-76214caa3167@linaro.org>
Date: Mon, 2 Oct 2017 14:27:57 -0400
MIME-Version: 1.0
In-Reply-To: <87y3otzk34.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 9/9] disas: Add capstone as submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 10:43 AM, Alex Bennée wrote:
>> +    mkdir -p capstone
> 
> Having a mkdir -p here seems a little out of place. Shouldn't the build
> directory creation be handled by the make recipe?

*shrug* We do this for the other directories at configure time.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYTDH-00037Q-VC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYTDH-0000Br-2p
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:23:07 -0400
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
Date: Fri, 21 Jul 2017 10:22:57 +0200
MIME-Version: 1.0
In-Reply-To: <d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 20.07.2017 20:59, Richard Henderson wrote:
> On 07/20/2017 05:04 AM, Alex Benn=C3=A9e wrote:
>> This is a massive but mechanical patch, the result of:
>>
>>    (cd fpu/softfloat3c; and find . | xargs dos2unix)
>>    (cd include/fpu/softfloat3c; and dos2unix *)
>>
>> Signed-off-by: Alex Benn=C3=A9e<alex.bennee@linaro.org>
>> ---
>=20
> Really shouldn't this have been part of the import?

+1
It's only a whitespace change, so please squash it in the previous patch
instead. (You could mention this in the patch description that line
endings have been changed to unix mode)

 Thomas

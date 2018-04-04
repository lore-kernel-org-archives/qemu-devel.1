Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3gWW-0005Ox-JT
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3gWT-0004xA-7w
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:24:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3gWT-0004wh-2w
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:24:13 -0400
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<87tvsrclsh.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b04fe74-2a84-63d8-5519-fd2fdfe3f4a3@redhat.com>
Date: Wed, 4 Apr 2018 13:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <87tvsrclsh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/mips_int: hold BQL for all
 interrupt requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

On 04/04/2018 12:23, Alex Benn=C3=A9e wrote:
>=20
>> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>>
>> Make sure BQL is held for all interrupt requests.
>>
>> For MTTCG-enabled configurations, handling soft and hard interrupts
>> between vCPUs must be properly locked. By acquiring BQL, make sure
>> all paths triggering an IRQ are synchronized.
>>
>> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
>> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Is this actually necessary?  What paths are not taking the lock?

Thanks,

Paolo

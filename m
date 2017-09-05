Received: from eggs.gnu.org ([2001:4830:134:3::10]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMik-0001rR-U4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMig-0005Hd-Gz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:53:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-7-git-send-email-peter.maydell@linaro.org>
	<a6b2c6cf-4cd0-cc99-daef-ab85f6a4b1a7@amsat.org>
Message-ID: <58accaee-f69c-e644-9218-6068dd4271ef@amsat.org>
Date: Tue, 5 Sep 2017 19:53:18 -0300
MIME-Version: 1.0
In-Reply-To: <a6b2c6cf-4cd0-cc99-daef-ab85f6a4b1a7@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/20] target/arm: Make BASEPRI
 register banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

> On 08/22/2017 12:08 PM, Peter Maydell wrote:
>> Make the BASEPRI register banked if v8M security extensions are enabled.
>>
>> Note that we do not yet implement the functionality of the new
>> AIRCR.PRIS bit (which allows the effect of the NS copy of BASEPRI to
>> be restricted).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

(forgot to add)

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

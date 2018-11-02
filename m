Received: from eggs.gnu.org ([2001:4830:134:3::10]:47138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIcwg-0008E7-Ot
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIcwa-0005cE-Rw
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:09:18 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53872 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1gIcwZ-0005a6-Ua
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:09:12 -0400
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
	<b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
	<87lg6b5shx.fsf@linaro.org>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <98428a27-8634-9521-297c-a61c618e867a@windriver.com>
Date: Fri, 2 Nov 2018 11:08:15 -0600
MIME-Version: 1.0
In-Reply-To: <87lg6b5shx.fsf@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 11/2/2018 10:55 AM, Alex Benn=C3=A9e wrote:
>=20
> Chris Friesen <chris.friesen@windriver.com> writes:
>> Given the "not initialized" message on the console, I wasn't sure
>> whether the kernel had even started yet.
>=20
> There will be a lot that happens between the kernel decompressing and
> some sort of video hardware output being started. You didn't say what
> guest architecture you were booting or what your qemu command line was.
> You might want to look at enabling the serial console and seeing if you
> get some clues from that.

The qemu commandline is in the "ps" output in my original message.=20
Guest arch is x86-64.

The serial console is a good idea, will try that.

Chris

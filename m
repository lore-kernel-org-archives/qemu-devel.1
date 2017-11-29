Received: from eggs.gnu.org ([2001:4830:134:3::10]:53701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJypx-0006m9-Mx
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJyps-0005iJ-Nm
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:39:25 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38199
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eJyps-0005hD-G7
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:39:20 -0500
References: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b36b0c95-4ddc-b818-522c-1bbec52138e8@adacore.com>
Date: Wed, 29 Nov 2017 10:39:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 645662] x87 fpu emulation not accurate enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: william lin <wlsaidhi@gmail.com>
Cc: qemu-devel@nongnu.org

Hi,

I have the same problem here with some of our math testsuites.
It's about some precision issue with trigonometric tests.

I didn't had time to figure out what happen neither what is
really going wrong. eg: trigonometric function or?

A quick workaround is to use KVM when possible.

Fred

On 11/29/2017 09:34 AM, william lin wrote:
> Hello,
> 
> I have been looking into this bug
> <https://bugs.launchpad.net/qemu/+bug/645662> for a school project, and
> after reproducing the bug and tracing through the code, I have run into a
> wall trying to figure out the best way to approach this. If there is anyone
> who is familiar with qemu's fpu and is willing, any tips or suggestions
> will be fantastic.
> 
> Thanks,
> 
> Will & Wes
> 

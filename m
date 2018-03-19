Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exyrP-0006JD-9R
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exyrJ-0002No-Po
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:46:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exyrJ-0002NK-KY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:46:09 -0400
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
	<1b9b4a96-c415-f96d-132a-82883d14d66c@amsat.org>
	<4f4b939b-b4a9-eaee-a8f5-d480d02a0b64@adacore.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8af6e56-3fd1-99c3-d9b9-ce7c4e06c52d@redhat.com>
Date: Mon, 19 Mar 2018 12:46:03 -0500
MIME-Version: 1.0
In-Reply-To: <4f4b939b-b4a9-eaee-a8f5-d480d02a0b64@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] gdbstub: send a terminaison
 packet instead of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: famz@redhat.com, stefanha@redhat.com

On 03/19/2018 04:52 AM, KONRAD Frederic wrote:
> Hi Philippe,
> 
> Thanks for the review!
> 
> BTW I forgot the for 2.12 tag can this be included in 2.12 or is
> it too late?

It's a bug-fix, so it can be included during softfreeze.  I've amended 
the subject line if it helps the right maintainer notice; or you can 
resend a v2 with the typos fixed, R-b comments added, and the 2.12 tag 
in your resend.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

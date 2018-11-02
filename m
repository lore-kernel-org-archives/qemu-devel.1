Received: from eggs.gnu.org ([2001:4830:134:3::10]:46994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIgKc-0005bl-8s
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 16:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIgKY-0002pI-Gl
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 16:46:13 -0400
Received: from mail5.windriver.com ([192.103.53.11]:56814 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1gIgKX-0002jH-RQ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 16:46:10 -0400
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
	<b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
	<87lg6b5shx.fsf@linaro.org>
	<98428a27-8634-9521-297c-a61c618e867a@windriver.com>
	<20181102175111.GA2388@work-vm>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <54304edc-9de4-a25a-63d0-96518c5d7956@windriver.com>
Date: Fri, 2 Nov 2018 14:45:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181102175111.GA2388@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, famz@redhat.com
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 11/2/2018 11:51 AM, Dr. David Alan Gilbert wrote:

> This is ringing a bell; if it's actually suck in the BIOS, then please:
>    a) Really make sure all your vCPUs are actually pinned/free on real
> CPUs
>    b) I suspect it is
>     https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00470.html

I'm still working on getting the BIOS logs to be emitted to file before 
kernel startup (I can see them later on, but not right at boot).

Will double-check the actual affinity next time I reproduce it (testcase 
has been going all day with no luck so far).

>     so the fix is Fam's 'aio: Do aio_notify_accept only during blocking
> aio_poll'.  I see you're running the qemu-kvm-ev from centos, if I read
> the version tea-leaves right, then I think that patch is in the
> 2.10.0-21.el7_5.7.1 package I can see.

It looks like we do not have this fix in our code, will definitely be 
giving it a try.

Thanks,
Chris

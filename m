Received: from eggs.gnu.org ([2001:4830:134:3::10]:52412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLqTm-0004l9-4u
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLqTi-0005yV-DJ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:40:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLqTh-0005xo-Vq
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:40:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id y15-v6so3199166wrg.11
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:40:25 -0700 (PDT)
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
	<20180518075212.GE3416@dnr> <20180518091916.GA22292@vader>
	<20180518130729.GF3416@dnr>
	<7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
	<20180523074757.GI26766@dnr>
	<397e4f8c-0913-6ffd-13fa-743abbbd47e4@linux.ibm.com>
	<eb079c9d-9251-bb2a-7cbc-5cb6423778db@redhat.com>
	<c113aa1c-a829-7a96-9874-b8ab48e84a29@linux.ibm.com>
	<8de364b2-a1c8-7a29-284c-6356d687638b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33d11137-210b-1a13-e258-d509f4876d67@redhat.com>
Date: Thu, 24 May 2018 15:40:10 +0200
MIME-Version: 1.0
In-Reply-To: <8de364b2-a1c8-7a29-284c-6356d687638b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: otubo@redhat.com, Yi Min Zhao <zyimin@linux.ibm.com>, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org

On 24/05/2018 09:53, Eduardo Otubo wrote:
>>>>>
>>>> Thanks! But I have not got response from Paolo.  I have added him to
>>>> CC list.
>>>>
>>>  I'll just wait one more ACK and will send a pull request on the
>>> seccomp queue. Thanks for the contribution.
>>>
>>>
>> So... what I should do is wait?
>>
> Yes, even though I think we're safe to proceed without his explicit ack.

The patch is okay; however, as a follow-up, you could consider moving
all the CONFIG_SECCOMP code to qemu-seccomp.c.

This way, the only #ifdef remains the one around qemu_opts_foreach.

Paolo

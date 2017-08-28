Received: from eggs.gnu.org ([2001:4830:134:3::10]:52778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmAgo-0000OR-Tv
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmAgl-0004We-P7
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:26:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41729
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmAgl-0004WE-JR
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:26:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S3Np2j098552
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 23:26:10 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ckphmmyd4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 23:26:10 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Sun, 27 Aug 2017 23:26:09 -0400
References: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
	<871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
	<20170824091332.01ff3698.cohuck@redhat.com>
	<26519e3e-3ef4-7b18-6d80-27941ee36df9@linux.vnet.ibm.com>
	<20d23300-2f98-7b38-afab-4c8971afb356@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 11:26:07 +0800
MIME-Version: 1.0
In-Reply-To: <20d23300-2f98-7b38-afab-4c8971afb356@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d47733fa-6f24-1bba-a54f-373a9074c9fd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] four zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com



=E5=9C=A8 2017/8/25 =E4=B8=8A=E5=8D=8812:27, Eric Blake =E5=86=99=E9=81=93=
:
> On 08/24/2017 03:48 AM, Yi Min Zhao wrote:
>>
>> =E5=9C=A8 2017/8/24 =E4=B8=8B=E5=8D=883:13, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> On Thu, 24 Aug 2017 13:20:12 +0800
>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>
>>>> Why can't I receive [Qemu-devel] prefixed patches?
>> I sent patches to qemu-devel@nongnu.org and cc you also myself.
>> But what I received looks like CC ones, no [Qemu-devel] prefix.
> You can tell mailman whether you want to receive copies of mails throug=
h
> the list even when you are listed in cc (defaults to on, but some peopl=
e
> like myself set it off to reduce mail); if you switch that option in
> your subscription settings, then you will not see the [Qemu-devel]
> prefix on any mail where you were cc'd.  [side note: turning off copies
> of mail where you are cc'd triggers what I consider to be a mailman bug=
:
> it actively rewrites the to/cc of the email to omit your address in the
> copy it sends to the list, which means people who follow up to the list
> no longer cc you, and do not know that you were cc'd in the first place=
]
I didn't tell mailman anything. So I think the receiving copies setting=20
is turned on.
What I can receive is only from cc. But as what Conny said, it seems=20
that other external reviewers
in cc list didn't receive any mail unless I replied a mail.
> Furthermore, there may be other places along the way that do data
> de-duplication.  For example, anyone subscribing via a gmail.com addres=
s
> gets at most one copy of a message based on the message-id; if they are
> subscribed to the mailing list and also get a cc of a given message,
> only one of those copies will show up (because google suppressed the
> second copy with the same message-id, even though the subject lines are
> different); the one copy is often (but not always) the one without the
> [Qemu-devel] prefix because cc'd mail goes through less processing and
> thus tends to arrive sooner than the copy sent through mailman.  [side
> note: google calls de-duplication a feature, but you can't turn it off,
> and it's one of the reasons that I don't use google for my personal ema=
il]
>

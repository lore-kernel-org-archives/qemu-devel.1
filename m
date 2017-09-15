Received: from eggs.gnu.org ([2001:4830:134:3::10]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsrtf-0001Vw-T1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsrtc-0000n6-Qx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:47:11 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsrtc-0000ms-Lq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:47:08 -0400
Received: by mail-qk0-x244.google.com with SMTP id i14so1561223qke.3
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 07:47:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
	<20170915114001.GG13610@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af84a70f-13a5-8c5d-48bb-ba62f57d24b8@amsat.org>
Date: Fri, 15 Sep 2017 11:47:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170915114001.GG13610@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Daniel,

On 09/15/2017 08:40 AM, Daniel P. Berrange wrote:
> On Fri, Sep 15, 2017 at 11:55:44AM +0100, Peter Maydell wrote:
[...]
>>
>> So, before I commit an ssh private key to our git repo,
>> can you explain why it's ok that this is public? The
>> commit message for the relevant patch doesn't really say.
> 
> IIUC, the public part of the key gets exposed to the guest images via
> cloud-init metadata. During boot the guest read this metadata and add
> the public key to authorized_keys. The private key is used by the test
> suite on the host so that it can now login to the guests.
> 
> So the risk here is that if these guests were exposed to the LAN in any
> way, someone could grab our private key and login to these guests.
> 
> What saves us is that the VMs are run with user mode slirp networking
> so AFAICT, aren't exposed to the LAN.  So as long as we don't change
> this to any kind of real networking, I think its acceptable to have
> the private key in it and doesn't expose developer's workstations to
> undue risk and avoids consuming system entropy to generate new keys
 > during build.

which systems are you worried about? build-farms or developer's stations?

why do you want to generate more than 1 key? why not generate 1 key in 
tests/vm/ (or clever ~/.cache/qemu-vm/ already used by those scripts) 
once when the make vm-test rule is called, that would be 1 key per 
repository clone (or 1 per user using ~/.cache).

Distrib aren't using the test suite in binary packages.

Regards,

Phil.

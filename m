Received: from eggs.gnu.org ([2001:4830:134:3::10]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIuuJ-0001oz-W0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIuuJ-0000TO-6f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIuuJ-0000T9-0R
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:43:15 -0400
References: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
	<bba5be37-e002-b65e-41b9-358e7f6a3ec9@redhat.com>
	<20170608085503.GA21945@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2f54a70-0169-35ed-6e55-46dccd4ee41e@redhat.com>
Date: Thu, 8 Jun 2017 12:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170608085503.GA21945@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] tcg: split the tcg code and
 separate tcg files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, laurent.desnogues@gmail.com, Xu@yangzhon-Virtual, Anthony <anthony.xu@intel.com>



On 08/06/2017 10:55, Zhong Yang wrote:
>>>
>> Queued, thanks (except I'm not sure why you're moving exec.c, so I've
>> undone that, and tcg-runtime.c probably fits better in tcg/).
>>
>   Thanks Paolo for your great help!
>=20
>   As for exec.c, i ever thought this file is related with system and mo=
ved here.

If we do that, there would many more files to move (e.g. ioport.c,
memory.c, user-exec.c).  I think it's better to leave exec.c in the root
for now.

>   You are right, since tcg-runtime.c is BSD Licenced, it should be move=
d to
>   tcg/.  Whether can i release V4 to do this moving?  =20

Don't worry, I can do the moving.

Paolo

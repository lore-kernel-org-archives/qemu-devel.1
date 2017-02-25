Received: from eggs.gnu.org ([2001:4830:134:3::10]:35845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVEx-000401-Us
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 00:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVEu-0004MC-SI
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 00:49:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chVEu-0004M6-Mn
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 00:49:52 -0500
References: <20170224135045.10613-1-mbenes@suse.cz>
	<d9d4d2c5-bede-6ea6-81cf-c2eaa2fccbd5@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e52f6865-22c7-5e72-ced2-39544e8a95d9@redhat.com>
Date: Sat, 25 Feb 2017 06:49:48 +0100
MIME-Version: 1.0
In-Reply-To: <d9d4d2c5-bede-6ea6-81cf-c2eaa2fccbd5@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Miroslav Benes <mbenes@suse.cz>, agraf@suse.de
Cc: ebischoff@suse.com, mmarek@suse.com, qemu-devel@nongnu.org

On 25.02.2017 00:51, Richard Henderson wrote:
> On 02/25/2017 12:50 AM, Miroslav Benes wrote:
>> Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
>> available in facilities list provided by stfl/stfle instruction. This is
>> the case of newer z/System generations and their qemu definition.
>>
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>> ---
> 
> I can't find LPP in my PoO 11th edition...

LPP is one of the instructions that is documented separately.
You can find its spec here, for example:

http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a

 Thomas

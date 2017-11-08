Received: from eggs.gnu.org ([2001:4830:134:3::10]:56670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCRu2-0002MK-Ts
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCRtz-00051t-PW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:04:30 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:56297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eCRtz-00050z-Jo
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:04:27 -0500
Received: by mail-wr0-f180.google.com with SMTP id l8so2677218wre.12
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:04:27 -0800 (PST)
References: <cover.1510093478.git.jcody@redhat.com>
	<41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
	<20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
	<a888b534-f285-6d02-fdb6-9faae79879fb@redhat.com>
	<20171108145038.7ms6llpt4vjnh33q@starbug-vm.ie.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e45ecd97-0fa2-edeb-ada2-c973b0edf4b6@redhat.com>
Date: Wed, 8 Nov 2017 16:04:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171108145038.7ms6llpt4vjnh33q@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/7] block/curl: code
 cleanup to comply with coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

On 08/11/2017 15:50, Darren Kenny wrote:
>> But, since checkpatch.pl doesn't flag it, and since it is easier to
>> remove the leading and trailing /* and */ to enable the debug #defines
>> (compared to editing every single line of the comment), I don't see a
>> problem with the style chosen here.
> 
> If that is the purpose, maybe an #if 0 is more appropriate or #ifdef
> DEBUG, or similar.
> 
> Isn't the purpose of styling to be consistent? As such should we not
> be trying to use the multi-line style set out at the top of the file?

Yes, and you're very welcome to submit a checkpatch.pl patch that warns
about that comment style without * at the beginning of each line.

On the other hand, style should not get in the way, and the version that
gets least in the way for debug #defines is //.

Paolo

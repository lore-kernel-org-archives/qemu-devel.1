Received: from eggs.gnu.org ([2001:4830:134:3::10]:45281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS0tJ-0006Vc-4K
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dS0tF-0006HZ-2C
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dS0tE-0006HH-R1
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:55:44 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
	<20170703102043.GE5663@redhat.com>
	<68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
	<20170703103340.GF5663@redhat.com>
	<650bf1e9-ba8c-c7a5-9e48-94dc970523d6@redhat.com>
	<20170703120945.GG5663@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1549bdf-d2f7-688c-f520-9549ea057464@redhat.com>
Date: Mon, 3 Jul 2017 14:55:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170703120945.GG5663@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com



On 03/07/2017 14:09, Daniel P. Berrange wrote:
>> It would leave you with a tools-only build; whether that's a good idea,
>> it's another story.  I think it's acceptable, but others may disagree.
> If you do 'configure --target-list=x86_64-softmmu --disable-tcg' on a
> non-x86 host I would be surprised to find  x86_64-softmmu not built.
> IMHO if you explicitly request system emulators and its not posisble
> to build then, an error should be report, rather than silently ignoring
> the request.

Technically you could build a qtest-only emulator, but I don't think
_that_ is a good idea (and it's not what the patch does).

Paolo

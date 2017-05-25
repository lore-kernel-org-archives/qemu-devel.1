Received: from eggs.gnu.org ([2001:4830:134:3::10]:41125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDoqe-0008RE-L4
	for qemu-devel@nongnu.org; Thu, 25 May 2017 05:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDoqd-0000i7-Ls
	for qemu-devel@nongnu.org; Thu, 25 May 2017 05:14:24 -0400
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<3e999ccc-5a8b-9111-06eb-d10bb83f6c43@redhat.com>
	<20170525074012.GB8487@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbb1e906-357c-6b9a-ff14-cce0041f94ea@redhat.com>
Date: Thu, 25 May 2017 11:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170525074012.GB8487@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/18] Block layer thread
 safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 25/05/2017 09:40, Fam Zheng wrote:
> On Wed, 05/24 10:32, Paolo Bonzini wrote:
>>
>> Ping?
>>
> 
> Looks good to me except for the mingw 32bit build failure reported by patchew:
> 
> http://patchew.org/QEMU/20170511144208.24075-1-pbonzini@redhat.com/
> 
> Do you want to fix it?

Sorry I missed that.  It's a configure issue for which I'll send a patch
shortly.

Paolo

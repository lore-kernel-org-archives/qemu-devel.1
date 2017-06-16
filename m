Received: from eggs.gnu.org ([2001:4830:134:3::10]:57417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLtxw-0000cV-2G
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLtxr-0004Wa-Qy
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLtxr-0004WJ-Ka
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:19:15 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
	<76504ef2-8dd0-ecbc-6e25-55be6abcb14a@redhat.com>
	<2d873cf2-11cd-1a2c-30e9-07d506685d37@redhat.com>
	<0a3dbc29-35cb-454b-d9c0-07304270c367@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06d509ea-afd5-1401-1cc0-b3088aa74ed0@redhat.com>
Date: Fri, 16 Jun 2017 18:19:11 +0200
MIME-Version: 1.0
In-Reply-To: <0a3dbc29-35cb-454b-d9c0-07304270c367@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 16/06/2017 18:15, Thomas Huth wrote:
> This is quite similar to trying to poison CONFIG_USER_ONLY ... every
> common file that depends on include/exec/memory.h or
> /include/exec/cpu-common.h then does not compile anymore - and as far as
> I can see, this can't be fixed with some trivial "#ifdef NEED_CPU_H"s in
> most cases anymore.

Oh, indeed. :(  I'll put removing ram_addr_t from memory.h on my todo
list.  I think most of those can go under NEED_CPU_H or can be replaced
with size_t.

Those parts of cpu-common.h instead should move to
include/exec/ram_addr.h sooner rather than later.

Paolo

> Since you've asked on IRC for a list of files which do not compile
> anymore in this case, here we go (some of them are also quite easy to
> fix, I think, but some need some bigger reworks, I guess):

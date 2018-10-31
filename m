Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHqU9-000057-RN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gHqU6-0004pe-Kb
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gHqTx-0004gZ-C6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:30 -0400
References: <20181031004550.15410-1-ehabkost@redhat.com>
	<20181031004550.15410-5-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b155bd2d-59e0-62f8-4928-3e938127816a@redhat.com>
Date: Wed, 31 Oct 2018 08:24:10 -0500
MIME-Version: 1.0
In-Reply-To: <20181031004550.15410-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 4/7] x86: Data structure changes to support
 MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/30/18 7:45 PM, Eduardo Habkost wrote:
> From: Robert Hoo <robert.hu@linux.intel.com>
> 
> Add FeatureWordType indicator in struct FeatureWordInfo.
> Change feature_word_info[] accordingly.
> Change existing functions that refer to feature_word_info[] accordingly.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> Message-Id: <1539578845-37944-3-git-send-email-robert.hu@linux.intel.com>
> [ehabkost: fixed hvf_enabled() case]

Eduardo, this is missing your S-o-b, which is odd for a pull request.

> ---
>   target/i386/cpu.c | 197 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 142 insertions(+), 55 deletions(-)
> 


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([209.51.188.92]:49305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomh7-0005SB-B3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomh6-0005od-Dh
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:02:09 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-2-git-send-email-thuth@redhat.com>
	<567dfcac-165d-5b8b-8179-6a981973111f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <723095a0-c4ac-29e4-c540-8bf195789516@redhat.com>
Date: Wed, 30 Jan 2019 11:02:02 +0100
MIME-Version: 1.0
In-Reply-To: <567dfcac-165d-5b8b-8179-6a981973111f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 2019-01-30 10:57, Paolo Bonzini wrote:
> On 30/01/19 10:43, Thomas Huth wrote:
>> CONFIG_SPAPR_RNG should stay in the ppc-softmmu.mak file since this
>> is a completely optional device.
> 
> What about making it
> 
>     default y
> 
> and adding to the .mak file this:
> 
> #CONFIG_SPAPR_RNG=n
> 
> I think the two approaches are more or less equivalent, but
> "#CONFIG_FOO=n" has a small advantage when the feature has a build-time
> dependency, such as CONFIG_MILKYMIST_TMU2's dependency on OpenGL.  In
> that case,
> 
>    CONFIG_MILKYMIST_TMU2=y
> 
> would report a contradiction if OpenGL is not available at build time, while
> 
>    default y
>    ...
>    #CONFIG_MILKYMIST_TMU2=n
> 
> would not.

I somehow dislike the idea of adding lines that are commented out by
default. For example, if someone later renames or removes the config
switch in the Kconfig files, the comment could stay there without being
noticed, while a CONFIG_XXX=y would cause a clean build failure if the
option is not available anymore.

 Thomas

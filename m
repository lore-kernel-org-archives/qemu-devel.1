Received: from eggs.gnu.org ([2001:4830:134:3::10]:49244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFKEZ-0004LT-HC
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFKEU-00069t-Hw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:25:03 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:61521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cFKEU-00069E-7r
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:24:58 -0500
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-2-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ca0a18a3-c007-9b72-3709-fcddb0d3b3d5@vivier.eu>
Date: Fri, 9 Dec 2016 13:24:12 +0100
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/20] Makefile: Allow CPU targets to
 reside in target/ folder, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Le 09/12/2016 à 13:17, Thomas Huth a écrit :
> To be able to compile the CPU targets from within a subfolder
> of the target/ folder, we've got to adapt the Makefile.target
> a little bit first. After this change, target CPUs can either
> reside in a target/xxx folder or continue to use the target-xxx
> scheme. The latter will be disabled once all targets have been
> moved.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile.target | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.target b/Makefile.target
> index 7a5080e..90b25ae 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -7,11 +7,17 @@ include config-target.mak
>  include config-devices.mak
>  include $(SRC_PATH)/rules.mak
>  
> +ifneq ($(wildcard $(SRC_PATH)/target/$(TARGET_BASE_ARCH)),)
> +TARGET_FOLDER=target/$(TARGET_BASE_ARCH)
> +else
> +TARGET_FOLDER=target-$(TARGET_BASE_ARCH)
> +endif

Perhaps you should consider to use ':=' instead of '='.

Laurent

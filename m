Received: from eggs.gnu.org ([2001:4830:134:3::10]:43213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fDrrY-0003Ut-Ah
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fDrrS-0000DY-PM
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:04 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:46749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fDrrS-0000A1-A3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:31:58 -0400
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <6e78d680-a659-c00e-2dd2-81966ecc99fb@lauterbach.com>
Date: Wed, 2 May 2018 14:31:39 +0100
MIME-Version: 1.0
In-Reply-To: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] ping Re: [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, khaled.jmal@lauterbach.com

ping

Le 4/19/2018 à 4:56 PM, Abdallah Bouassida a écrit :
> The previous version:
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=33714
>
> Abdallah Bouassida (3):
>   target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
>     type
>   target/arm: Add "_S" suffix to the secure version of a sysreg
>   target/arm: Add the XML dynamic generation
>
>  gdbstub.c            | 10 +++++++
>  include/qom/cpu.h    |  5 +++-
>  target/arm/cpu.c     |  1 +
>  target/arm/cpu.h     | 29 +++++++++++++++++++-
>  target/arm/gdbstub.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c  | 57 ++++++++++++++++++++++++++++++---------
>  6 files changed, 164 insertions(+), 14 deletions(-)
>

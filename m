Received: from eggs.gnu.org ([209.51.188.92]:35242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YLz-000867-GI
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YLy-00025B-Uk
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:33:15 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2YLy-00024c-JL
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:33:14 -0500
References: <20190306031221.GA53@03612eec87fc>
	<20190306044244.GB75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <84dc1716-4fb3-8ad4-b8e3-15548212f2ef@vivier.eu>
Date: Sat, 9 Mar 2019 10:32:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190306044244.GB75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/10] qemu-binfmt-conf.sh: make opts -p
 and -c boolean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com

On 06/03/2019 05:42, Unai Martinez-Corral wrote:
> This patch breaks backward compatibility.
> 
> Both '--persistent' and '--credential' default to 'no'. Hence, '-p no'
> or '-c no' are reduntant. Overall, accepting an argument might be
> misleading because options are, indeed, boolean. This patch makes both
> options boolean in getopt, so if any of them is provided the corresponding
> variable is set to true.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

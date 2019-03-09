Received: from eggs.gnu.org ([209.51.188.92]:36986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YWR-0003ft-25
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YWP-0008LN-4l
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:44:03 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2YWN-0008JU-6n
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:44:01 -0500
References: <20190306031221.GA53@03612eec87fc>
	<20190306044914.GD75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fb3d1350-a616-714e-a3e0-85a32a4bae88@vivier.eu>
Date: Sat, 9 Mar 2019 10:43:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190306044914.GD75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/10] qemu-binfmt-conf.sh: remove 'qemu'
 prefix from cli options
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

On 06/03/2019 05:49, Unai Martinez-Corral wrote:
> This breaks backward compatibility.
> 
> Options 'qemu-path' and 'qemu-suffix' have the 'qemu-' prefix, which is
> not present in other option names ('debian', 'systemd', 'persistent',
> 'credential'...). In order to keep consistency, the prefix is removed.
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

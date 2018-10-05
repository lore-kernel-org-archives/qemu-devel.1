Received: from eggs.gnu.org ([2001:4830:134:3::10]:51136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QJD-0005jQ-2k
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QJ8-0004uV-GS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:38:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QJ7-0004r9-76
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:38:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so13607390wrw.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:38:17 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23326c24-24cf-cf7b-fca7-c702765600c2@redhat.com>
Date: Fri, 5 Oct 2018 15:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: fix filename
 containing checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 18:18, Cleber Rosa wrote:
> Commit cce293a2945 moved some functions from common.config to
> common.rc, but the error messages still reference the old file
> location.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/common.rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 44bee16a5e..70ca65b49b 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -170,7 +170,7 @@ if [ ! -e "$TEST_DIR" ]; then
>  fi
>  
>  if [ ! -d "$TEST_DIR" ]; then
> -    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
> +    echo "common.rc: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
>      exit 1
>  fi
>  
> @@ -179,7 +179,7 @@ if [ -z "$REMOTE_TEST_DIR" ]; then
>  fi
>  
>  if [ ! -d "$SAMPLE_IMG_DIR" ]; then
> -    echo "common.config: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
> +    echo "common.rc: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
>      exit 1
>  fi
>  
> 

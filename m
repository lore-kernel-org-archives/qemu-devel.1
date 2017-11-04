Received: from eggs.gnu.org ([2001:4830:134:3::10]:33036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@stuge.se>) id 1eAvV2-0005vZ-SU
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 06:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@stuge.se>) id 1eAvUz-00085L-O0
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 06:16:24 -0400
Received: from foo.stuge.se ([212.116.89.98]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peter@stuge.se>) id 1eAvUz-00083B-Bn
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 06:16:21 -0400
Date: Sat, 4 Nov 2017 10:09:08 +0000
From: Peter Stuge <peter@stuge.se>
Message-ID: <20171104100908.GS4167@stuge.se>
References: <20171103075753.23217-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103075753.23217-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH] Ignore sgabios rom in case
 sercon is enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios@seabios.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

Gerd Hoffmann wrote:
> +++ b/src/optionroms.c
> @@ -193,6 +193,11 @@ run_file_roms(const char *prefix, int isvga, u64 *sources)
>          file = romfile_findprefix(prefix, file);
>          if (!file)
>              break;
> +        if (strcmp(file->name, "vgaroms/sgabios.bin") == 0 &&
> +            CONFIG_SERCON && romfile_loadint("etc/sercon-port", 0)) {
> +            dprintf(1, "sercon: is enabled, not loading sgabios rom.\n");
> +            continue;
> +        }

This heuristic isn't very reliable. Is there nothing in the sgabios.bin
option ROM itself that can be used instead?


//Peter

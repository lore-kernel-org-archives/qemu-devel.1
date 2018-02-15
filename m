Received: from eggs.gnu.org ([2001:4830:134:3::10]:52032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLAn-0000gd-OS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1emLAn-0008Bd-0c
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:10:09 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
	<1518664462-2960-2-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6a46ae1c-0d64-48b6-c567-5e72b1ad009c@twiddle.net>
Date: Thu, 15 Feb 2018 07:09:56 -0800
MIME-Version: 1.0
In-Reply-To: <1518664462-2960-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] translator: add retcode to
 translator_loop_temp_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 02/14/2018 07:14 PM, Emilio G. Cota wrote:
> -void translator_loop_temp_check(DisasContextBase *db);
> +int translator_loop_temp_check(DisasContextBase *db);
>  

bool.

Although I don't see how this is helpful.  If you want to customize the output,
surely you just use tcg_check_temp_count directly?


r~

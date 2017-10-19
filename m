Received: from eggs.gnu.org ([2001:4830:134:3::10]:56087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e54en-0005s8-Ta
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e54ek-0006Qh-Ng
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e54ek-0006Oo-AQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:50:14 -0400
References: <20171016131644.9565-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19f64376-dcae-7185-110f-9970299666b2@redhat.com>
Date: Thu, 19 Oct 2017 08:50:02 +0200
MIME-Version: 1.0
In-Reply-To: <20171016131644.9565-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171016 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 16.10.2017 15:16, Gerd Hoffmann wrote:
> The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:
> 
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kraxel.org/qemu tags/ui-20171016-pull-request
> 
> for you to fetch changes up to 2ff408de9c080f2fb5a94ebf6a209c6180c64933:
> 
>   gtk: fix wrong id between texture and framebuffer (2017-10-16 14:50:54 +0200)
> 
> ----------------------------------------------------------------
> ui: use keycodemapdb for key code mappings, part one (v2)
> ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
> ui: fix for vte 0.50
> ui: gtk texture fix

I just noticed that I now get the following warning message when I
change to an older git branch:

warning: unable to rmdir ui/keycodemapdb: Directory not empty

... this is kind of ugly, is there a way to fix this?

 Thomas

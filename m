Received: from eggs.gnu.org ([209.51.188.92]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJbX6-0003MI-3B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJbX4-0004ns-Ne
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJbX4-0004nG-FL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so9745935wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 03:23:09 -0700 (PDT)
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
	<CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d773a58b-e33c-fa66-5afc-05bdc85efa53@redhat.com>
Date: Thu, 25 Apr 2019 12:23:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 4/25/19 10:29 AM, Li Qiang wrote:
> 
> 
> Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>> 于2019年4月
> 25日周四 下午4:15写道：
> 
>     On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
>     > Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> 于2019年4
>     月24日周三 上午12:29写道：
>     >
>     > > Is this endianess-safe? Or do you need to byteswap
>     reboot_timeout if the
>     > > host and guest endianess does not match?
>     >
>     > Good question!
>     >
>     > IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
> 
>     No.  Integers are defined to be little endian.  See fw_cfg_add_i64() for
>     example, there is an explicit cpu_to_le64() call for that.
> 
> 
> 
> Yes, for the fw_cfg 'integer' entry it is stored as little endian.
> But for the fw_cfg 'file' entry interpred as an integer, there is no
> specify the endianess.

I agree with Li, the endianess of 'reboot-timeout' is not clear.

>From docs/specs/fw_cfg.txt:

  === All Other Data Items ===

  Please consult the QEMU source for the most up-to-date
  and authoritative list of selector keys and their respective
  items' purpose, format and writeability.

So checking the git history, this code was introduced in commit
ac05f3492421, very similar to commit 3d3b8303c6f8 for the
'boot-menu-wait' entry, which explicitely use little-endian, so I think
it is safe to consider it little-endian and add a comment about its
endianess (referring the previous commits in the patch description).

Thanks,

Phil.

> 
> Thanks,
> Li Qiang
> 
>  
> 
>     cheers,
>       Gerd
> 

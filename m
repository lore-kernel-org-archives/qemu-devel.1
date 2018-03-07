Received: from eggs.gnu.org ([2001:4830:134:3::10]:51572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1etcM3-0000cw-NF
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1etcM2-00022F-N2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:55:51 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1etcM2-00020g-DH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:55:50 -0500
Received: by mail-lf0-x244.google.com with SMTP id i80-v6so4241481lfg.5
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 08:55:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu, 8 Mar 2018 00:55:48 +0800
Message-ID: <CAKwiv-h4HJkt3QM-dakH54CY_1wgDkGtt5+wTQg396TdH_CUXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] vmmouse: convert qdev pointer property
 to QOM link relationship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

 Hi all, this is a bitesized patch from me a while ago, it seems a little
old but I wonder if there is any opinion about it? Is it still valid?

Thanks.

2018-02-04 15:28 GMT+08:00 Zihan Yang <whois.zihan.yang@gmail.com>:

> The ps2_mouse property of vmmouse is still pointer type which
> is defined by DEFINE_PROP_PTR. But qdev pointer property should
> be avoided according to qdev-properties.h. Convert it to
> QOM link relationship.
>
> It involves two patches because it requires the TYPE_I8042
> macro which is defined in another file. The first patch put
> this macro into a single header file so that the macro can
> be used elsewhere. The second patch does the actual work.
>
> Zihan Yang (2):
>   hw/input/pckdb: put TYPE_I8042 into a single header file
>   vmmouse: change qdev pointer property to qom link
>
>  hw/i386/pc.c      |  2 +-
>  hw/i386/vmmouse.c | 19 ++++++++++++-------
>  hw/input/pckbd.c  |  2 +-
>  hw/input/pckbd.h  |  6 ++++++
>  4 files changed, 20 insertions(+), 9 deletions(-)
>  create mode 100644 hw/input/pckbd.h
>
> --
> 2.7.4
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3TC-00019b-JD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG3TB-0002N9-OB
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:19:58 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG3TB-0002Mz-Ij
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:19:57 -0400
Received: by mail-oi0-x22f.google.com with SMTP id v2-v6so28485496oif.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 07:19:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525691524-32265-1-git-send-email-imammedo@redhat.com>
References: <1525691524-32265-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 15:19:36 +0100
Message-ID: <CAFEAcA8vrk2VJBDrWkTCqa=5g3+6tTf-ijHF7w42+zwhBEJzbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] arm: isolate and clean up dtb
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 7 May 2018 at 12:12, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Changelog v3->v4:
>    * dropped "arm: boot: set boot_info starting from  first_cpu",
>      since it's applied to target-arm.next
>    * fix crash (in 3/4) when QEMU tried to load DTB but none was provided,
>      get_dtb() hook isn't set by most ARM boards so such boards crash
>      trying to call it. Check if there is DTB before trying to load it.

Thanks, applied this version to target-arm.next.

-- PMM

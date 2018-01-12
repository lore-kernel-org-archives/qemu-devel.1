Received: from eggs.gnu.org ([2001:4830:134:3::10]:34054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea1lz-0003HC-Tj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea1lz-0000lk-5Q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:01:39 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea1lz-0000l2-18
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:01:39 -0500
Received: by mail-ot0-x244.google.com with SMTP id f6so5401771oti.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:01:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515762528-22818-1-git-send-email-peter.maydell@linaro.org>
References: <1515762528-22818-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 16:01:17 +0000
Message-ID: <CAFEAcA-ytJg0QN_ZAzuKMEvs0iT_Wg37Sbn4ROB8Gcw8zF=bgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: Remove duplicate typedef of
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 12 January 2018 at 13:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> Some older versions of gcc complain if a typedef is defined twice:
>
> target/xtensa/translate.c:81: error: redefinition of typedef 'DisasContext'
> target/xtensa/cpu.h:339: note: previous declaration of 'DisasContext' was here
>
> Remove the now-redundant typedef from the definition of the struct in
> translate.c.
>
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

...applied to master as a buildfix.

-- PMM

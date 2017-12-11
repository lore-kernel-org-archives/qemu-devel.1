Received: from eggs.gnu.org ([2001:4830:134:3::10]:52388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOKXZ-0001ag-FW
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOKXY-0005MN-Ol
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:38:25 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOKXY-0005Ll-Ix
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:38:24 -0500
Received: by mail-ot0-x242.google.com with SMTP id q3so14182571oth.2
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 01:38:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 09:38:03 +0000
Message-ID: <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 8 December 2017 at 19:40, Eric Blake <eblake@redhat.com> wrote:
> On 12/08/2017 04:55 AM, Paolo Bonzini wrote:
>> Likewise,
>>
>>     QEMU_WITH_LOCK(QemuMutex, guard_name, &some_mutex) {
>>         ...
>>     }
>>
>> is the same as
>>
>>     qemu_mutex_lock(&some_mutex);
>>     ...
>>     qemu_mutex_unlock(&some_mutex);
>>
>> except that any returns within the region will unlock the mutex.
>
> Not just returns, but ANY manner that you leave the scope, including a
> goto or just falling out of the end of the scope.

How about longjmp()ing out of it?

thanks
-- PMM

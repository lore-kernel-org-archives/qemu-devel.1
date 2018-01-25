Received: from eggs.gnu.org ([2001:4830:134:3::10]:57522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eehYj-0006WW-Pg
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eehYf-000511-Rx
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:27:17 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eehYf-000509-LP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:27:13 -0500
Received: by mail-wr0-f195.google.com with SMTP id w50so2175743wrc.2
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 05:27:13 -0800 (PST)
References: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
	<20180125124511.GG1776@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8127262-47c0-f8c8-944d-79ea2398fa3a@redhat.com>
Date: Thu, 25 Jan 2018 14:27:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180125124511.GG1776@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Klim Kireev <klim.kireev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On 25/01/2018 13:45, Daniel P. Berrangé wrote:
>> index e54388015a..558cd81bdd 160000
>> --- a/dtc
>> +++ b/dtc
>> @@ -1 +1 @@
>> -Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
>> +Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
> Presumably accidental. You can fix this by doing
> 
>   cd dtc
>   git checkout e54388015af1fb4bf04d0bca99caba1074d9cc42
>   cd ..
>   git add dtc
>   git commit --amend

Also, I think:

    git checkout HEAD^ -- dtc
    git commit --amend
    git submodule update

Paolo

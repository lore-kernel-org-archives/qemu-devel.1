Received: from eggs.gnu.org ([2001:4830:134:3::10]:36950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHszv-0004SV-E0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHszj-0007AC-Vk
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHszh-0006n7-LM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:05:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so17055689wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:05:03 -0700 (PDT)
References: <20181031053920.7565-1-famz@redhat.com>
	<1d819a62-3fb0-d039-4cda-0b0a542979e3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e44b5b5-c76b-d1f0-b899-84429a086456@redhat.com>
Date: Wed, 31 Oct 2018 17:05:00 +0100
MIME-Version: 1.0
In-Reply-To: <1d819a62-3fb0-d039-4cda-0b0a542979e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 31/10/18 15:57, Eric Blake wrote:
> On 10/31/18 12:39 AM, Fam Zheng wrote:
...
>> -        fprintf(stderr, "%s: stat failed: %s\n",
>> -            fname, strerror(errno));
>> +        error_setg(errp, "%s: stat failed: %s", fname, strerror(errno));
>>           return -errno;
> 
> error_setg_errno() is nicer here.  In fact, should we have a Coverity 
> script that looks for error_setg(... strerror())?
> 

Coverity -> Coccinelle?

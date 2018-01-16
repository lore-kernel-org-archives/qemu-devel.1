Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebGoF-0000S9-IT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebGoB-0000FR-0A
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:17:07 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebGoA-0000AU-PX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:17:02 -0500
Received: by mail-wm0-f41.google.com with SMTP id f71so5281039wmf.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 18:17:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115132636.33905fde.cohuck@redhat.com>
References: <20180115114841.GH8218@redhat.com>
	<20180115132636.33905fde.cohuck@redhat.com>
From: Fam Zheng <fzheng@redhat.com>
Date: Tue, 16 Jan 2018 10:16:28 +0800
Message-ID: <CAK1Eb9=c08yNKiNysQp6nprcMKDhRF2FH-pCe278gJEQSzP-KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFE for patchew docker result reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com

On Mon, Jan 15, 2018 at 8:26 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, 15 Jan 2018 11:48:41 +0000
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>
>> Currently if I look at the patchew website for build logs, the 'docker'
>> job results are listed as a single expandable item.
>>
>> Patchew runs 3 separate docker builds, however, and there's a tonne of
>> output to scroll through to find which one actually failed.
>>
>> Thus, my RFE is to split the build log up so that instead of a single
>> "docker" result, it shows  "docker quick", "docker biuld" and
>> "docker mingw" as separate build logs / results. This would make it
>> easier to see at a glance which scenario failed.
>
> +1. Splitting the output into smaller units makes sense to me.

Made the proposed change on patchew.org. Thanks.

Fam

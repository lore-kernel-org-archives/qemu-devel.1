Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGVs-0002Yp-GO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGVp-0001Hi-Ew
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbGVp-0001Gw-8o
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:53:33 -0500
References: <20161202210152.6880-1-lersek@redhat.com>
	<eaa65150-d42b-caa7-0666-9ab018646fc1@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <acc8f22a-6042-591a-0f80-c839f1ccd8ef@redhat.com>
Date: Wed, 8 Feb 2017 01:53:29 +0100
MIME-Version: 1.0
In-Reply-To: <eaa65150-d42b-caa7-0666-9ab018646fc1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 02/07/17 20:20, Eric Blake wrote:
> On 12/02/2016 03:01 PM, Laszlo Ersek wrote:
>> When passed to git-diff (and to every other git command producing diffs
>> and/or diffstats) with "-O" or "diff.orderFile", this list of patterns
>> will place the more declarative / abstract hunks first, while changes to
>> imperative code / details will be near the end of the patches. This saves
>> on scrolling / searching and makes for easier reviewing.
>>
>> We intend to advise contributors in the Wiki to run
>>
>>   git config diff.orderFile scripts/git.orderfile
>>
>> once, as part of their initial setup, before formatting their first (or,
>> for repeat contributors, next) patches.
> 
> Presumably, we'd also want this to be mentioned in HACKING?

Presumably. :)

> 
>>
>> See the "-O" option and the "diff.orderFile" configuration variable in
>> git-diff(1) and git-config(1).
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
> 
> Is it time to revive this patch?

Time for whom? :)

Cheers,
Laszlo

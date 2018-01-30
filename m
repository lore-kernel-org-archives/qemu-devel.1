Received: from eggs.gnu.org ([2001:4830:134:3::10]:46401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egPWD-0000uI-LQ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egPW8-0002z5-Nw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:35:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egPW8-0002yf-HW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:35:40 -0500
Received: by mail-wr0-f196.google.com with SMTP id i56so9804233wra.7
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 22:35:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
References: <20171226025247.11082-1-famz@redhat.com>
	<20171226025247.11082-3-famz@redhat.com>
	<7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 30 Jan 2018 14:35:08 +0800
Message-ID: <CAK1Eb9=cYLxEezGWz8_vSQeqkjsc11uT6JmXcC+2ECrKJNNNcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Jan 30, 2018 at 12:01 AM, Max Reitz <mreitz@redhat.com> wrote:
> On 2017-12-26 03:52, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  qemu-img.texi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index 60a0e080c6..e83e140f7a 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -86,6 +86,15 @@ exclusive with the @var{-O} parameters. It is currently required to also use
>>  the @var{-n} parameter to skip image creation. This restriction may be relaxed
>>  in a future release.
>>
>> +@item --force-share (-U)
>> +
>
> So the previous patch makes the use of blank lines consistent and this
> one breaks it again? :-)

Good point, will fix.

>
>> +If specified, @code{qemu-img} will open the image with shared permissions,
>> +which makes it less likely to conflict with a running guest's permissions due
>> +to image locking. For example, this can be used to get the image information
>> +(with 'info' subcommand) when the image is used by a running guest. Note that
>> +this could produce inconsistent results because of concurrent metadata changes,
>> +etc. This option is only allowed when opening images in read-only mode.
>
> I personally don't quite like the "makes it less likely to conflict",
> because that makes it sound like qemu would be stupid and need a nudge
> in the right direction -- when it's actually the user who does something
> a bit risky (and qemu is right in forbidding it by default).  But since
> it's only a read-only thing, I won't actually object to it.
>
> (Maybe it should document more exactly what's happening, i.e. that this
> option will allow concurrent writers (as a standard user, I wouldn't
> know what "shared permissions" is supposed to mean).)

Makes sense to me. Sending v6.

Fam

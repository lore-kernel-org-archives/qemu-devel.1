Received: from eggs.gnu.org ([2001:4830:134:3::10]:37791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRbGb-00061s-V0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRbGX-0002ay-Ic
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:25 -0500
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:38862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRbGX-0002Ym-Ab
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:06:21 -0500
Received: by mail-lf0-x232.google.com with SMTP id w196so5402497lff.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 02:06:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171205151553.7834-1-famz@redhat.com>
	<20171220095104.GB10812@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af9ceced-6a51-1fef-916b-69602403c2a4@redhat.com>
Date: Wed, 20 Dec 2017 11:06:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171220095104.GB10812@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 20/12/2017 10:51, Fam Zheng wrote:
> On Tue, 12/05 23:15, Fam Zheng wrote:
>> Add the property to the device model, then parse it by calling
>> blkconf_apply_backend_options().
>>
>> In addition to blk_set_perm(), the called function also handles error
>> options and wce. For error options we've already checked that the
>> default values are used, for wce we don't have the option either so it
>> is always the default (true). In other words there is no change of
>> behavior in these regards.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Ping? :)

Already queued.

Paolo

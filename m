Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131FCC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80DD20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80DD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfzS-0001Sn-5d
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:08:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfyC-0000kA-Ar
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfyB-0003tw-CN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:06:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfy8-0003jj-Oy; Thu, 11 Apr 2019 16:06:45 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MeCYx-1gdPaw3s7L-00bHiM; Thu, 11 Apr 2019 22:01:30 +0200
To: Markus Armbruster <armbru@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
References: <20190311083234.20841-1-richardw.yang@linux.intel.com>
	<20190312084313.webcenp43tk3yfmm@steredhat>
	<87tvfghqg7.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <51367507-2b5a-151d-af0f-5404448bbdad@vivier.eu>
Date: Thu, 11 Apr 2019 22:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87tvfghqg7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:23VmX65z7zcw3eA8ma19KipOHGAOQ/RGNYlSOeDq70vxdPniDFS
	nuTbIdrtCzMjOUVcX2Qfg0q1Bps+e5biIntQwjxd0ic4VA5C0e0CFakBLJDllRHC+RYJYlX
	hlBXS3Ms01x47ddHHPbugm8fZgBesc7DhnRRb5eTuBoAsYjuZq7UZDrw85Ro9p6z8PgbDeB
	YGy8DbuRj9wevWUFjeRzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mgSHuX1mVUs=:AYO5QZJVe+2+iithowgRVz
	2F4YQbaGNLKOKPmR9e2Ot6xLuclCILlj9Ja3R+srIwzGrrJTltJaO85UnJYSNRW/xlE1PZV8X
	HXxPeqTNrgMbg5EWTaSaRReGMHuV8aBA+iPTUq/7P1ojOh3P5pCC/pqhSAI3h9UBNHBx5C3Y/
	tFJ2XnSJ8ceK6+nLnbAEseFZvYtK8Agf8rRhvQnn0O4l4qdObVmi+Q/UohvpvRsbfuPayBltb
	2eakvrlf7+A2tCSg2mPT+c/aOGUfzYQfzXYKKPdTXJNBexR1qiBen/TewCDpmwm6NztHkc2aL
	lDUz639UvIloMpgBcJ3FzgeLEjNpIA+93AMJ6WnxkQs1Bv29pWVAyMWUh1U9CoOdVy+4IKEVq
	UmKTAKJ/vn5sWBXIfz1r7VFGX+TW+DBeIhXRvXs0X9nLx7rkwsWEkPEmkv7KMXLRm50DzwwSM
	BQ7RUSxud0LXCGlxJxn8difmevE0QrhiWRjggYFhbcs1k2MPgE7+GgWm+TDI6f3IiXTVr/+7P
	DJ7f+UUqEgFTh2O0owcz1wMPVtepngTAOZ5Y6agzXB55aYjNthvHVSbddRAQK5QtZ5S9r5xBK
	eYd7045dNiZrdnR0XYLldTt/Uwse+il3rqISe1PVqnOgk+C3svRovSv3MeXkK3vAXheJE3F3T
	33HngOyzZ8g3F+bUhNQLMizSpAEfbN9Ub6vTK38SVB0dvwCJjFGoS9OoDLjpNYI+vCDUYXUEZ
	CwuiEDQVb9w9HK6SDgQHeQR5d1OKciitMTU5ytYu+30YKwWf71iu+HNg71g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qom: use
 object_new_with_type in object_new_with_propv
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411200128.yn9w84KPZfOF9dtQim0k7uOcDvlsiLI5njyVKTJilCU@z>

On 02/04/2019 08:27, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
>> On Mon, Mar 11, 2019 at 04:32:34PM +0800, Wei Yang wrote:
>>> Function object_new_with_propv already get the Type of the object, so we
>>> could leverage object_new_with_type here.
>>>
>>> [make check test pass]
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  qom/object.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> LGTM. Just a note for future patches:
>> I think that info like "[make check test pass]" should go after the
>> three dashes to avoid to store it in the commit message.
> 
> Yes.  Whoever applies  should delete this line.
> 
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Cc: qemu-trivial for merging.
> 

Applied to my trivial-patches branch with updated commit message.

Thanks,
Laurent


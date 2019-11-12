Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A644C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F075020650
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075020650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSdx-00068m-6s
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUScV-0004Yc-Lp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUScU-0007UK-Gg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:37:55 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iUScU-0007U2-7w; Tue, 12 Nov 2019 04:37:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MPXMa-1iGcy93mi2-00MdPb; Tue, 12 Nov 2019 10:36:28 +0100
Subject: Re: [PATCH v2] ivshmem-server: Clean up shmem on shutdown
To: Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
 <2587815f-e4eb-1f44-0b2d-5b77e3337553@suse.de>
 <7c4cb51d-ce45-4324-811b-4674ab9aa691@siemens.com>
 <87eeyi8kny.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d18914f3-6760-ff6a-3914-956856b4ccdf@vivier.eu>
Date: Tue, 12 Nov 2019 10:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87eeyi8kny.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qz4EmSDynfqaF8BVNus9esc1IxUDMYZM9noeiVw4HLLaFlFyLbK
 0j1aFaUvS9STz6futnqrOS2lU/2qKosoc31qwJJujV2ONePybdoNFib4qyuJ7PY96kEq6mD
 iie1FpUbJBAQ2zT9zce/FypWytEX0BVu91WnMlmd//XsCeFhH+AQx/sCXsiVqgToSIauxk8
 vPNbOB9Lo3e+dQpZUAL9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQRRcULPSZI=:VUOi/OJ5q4AbgwZI9SilZG
 XpqpuH6Km+OmdIk/OR7fdpP3dDds061BbJRooqAkaNt8vobNakxxJywLuw6gUEhW+gVjT5kps
 Ga1c21F5sahzeurkmichfZMPteFHwaLHfylBi5E34ptQv8V2UQ5eYnwd2QM45TV0fVhw8RuXR
 zdABjX9e2bne1DR7qJtQNBwnMr5EXMG/3gDrIQgMN+cMWlZuvDdIudq54Vfx3i44HtyNdiIV0
 pELCh0OQiPEkGuSmNlHiW+R4zcqo0Yef39nUZND3gegfxQeAHKTD/+zn0I7ek/jc4kwwTMohB
 ODDBn4tEU41V2zlo+zMWDiInadrhsMCOiTPs0/pyVIQltbSfjDxDj/+GhQwqUbpuMw9MJaqIB
 jaeX6hTqs+LcYDKpyH9a1Z1yopsKKySW5jjflXsxzSs6KQCkVxuhvQUWl+e8wsBZdtWkxP2TD
 k4uXmXEofd+znup1Iz37Q640/5XbX5zarq2OB5lo/Zd1Ur6r+V65Qwe6vml/LhpXAfMC3Ws8e
 w6v06w+HiC/qhCVT4tK9G8yKYXv02CKRkWiQixlixcCGvFdIPXiEMAilqA349c5OjgG+r+t/A
 VJO1DzpWCs6Ix5+aTp+oTZeEsMZK10/kmEVE9LxvvCcEWfRgHCdZ/PN0XkX2LU3I3Pl3W56nW
 zEuN0m9es+uv4myI3HS6wlrnaKMaE959j7VItwerOgJsIs/lkcHjsIesM+z6tzWoJoDuhoyun
 tFyb5SH2HyTgjg7qcvNQWGYcs2QqP9aTkW0+UtxmUl8DpFiizPXCl/7t2loP23WVqwvtlvbcZ
 BmwEfQjNFSxPyfWHSdGWk612KAU3l4LfRUmbbeax7GSUoJR3L/obGlsddnrF4IS7H3pgSftig
 XZ/fF19xYs567ja2OGbw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Claudio Fontana <claudio.fontana@suse.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/11/2019 à 16:14, Markus Armbruster a écrit :
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 06.08.19 15:01, Claudio Fontana wrote:
>>> On 8/5/19 7:54 AM, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> So far, the server leaves the posix shared memory object behind when
>>>> terminating, requiring the user to explicitly remove it in order to
>>>> start a new instance.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>   - respect use_shm_open
>>>>   - also clean up in ivshmem_server_start error path
>>>>
>>>>   contrib/ivshmem-server/ivshmem-server.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
>>>> index 77f97b209c..88daee812d 100644
>>>> --- a/contrib/ivshmem-server/ivshmem-server.c
>>>> +++ b/contrib/ivshmem-server/ivshmem-server.c
>>>> @@ -353,6 +353,9 @@ ivshmem_server_start(IvshmemServer *server)
>>>>   err_close_sock:
>>>>       close(sock_fd);
>>>>   err_close_shm:
>>>> +    if (server->use_shm_open) {
>>>> +        shm_unlink(server->shm_path);
>>>> +    }
>>>>       close(shm_fd);
>>>>       return -1;
>>>>   }
>>>> @@ -370,6 +373,9 @@ ivshmem_server_close(IvshmemServer *server)
>>>>       }
>>>>
>>>>       unlink(server->unix_sock_path);
>>>> +    if (server->use_shm_open) {
>>>> +        shm_unlink(server->shm_path);
>>>> +    }
>>>>       close(server->sock_fd);
>>>>       close(server->shm_fd);
>>>>       server->sock_fd = -1;
>>>> --
>>>> 2.16.4
>>>>
>>>>
>>>
>>> Reviewed-by: Claudio Fontana <claudio.fontana@suse.com>
>>
>> Markus, would you take this?
> 
> ivshmem has no maintainer.  I you need me to serve as a pull request
> monkey of last resort, I can do that.  However, for this one,
> qemu-trivial (cc'ed) should do.
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


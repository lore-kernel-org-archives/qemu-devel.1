Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B102820658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uiZB5uu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B102820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8hnh-0004ng-VU
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8hn4-0004Ig-JX; Thu, 20 Aug 2020 06:27:26 -0400
Received: from mail-db8eur05on2125.outbound.protection.outlook.com
 ([40.107.20.125]:64608 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8hn0-0003D1-Sj; Thu, 20 Aug 2020 06:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5Q023Zo5w/JuBnx+1D08ai96osYXmVShHFN1LWQtDCIdp0h4sKt4ghsiNuSPijNSojS7TfAlb2CWt6Xj05LKniTuE/wPDFmBACpv+Guvakq0bW02hJpwe59jUly9VqA14p9LdQT5voIWWeG2SXHQdRk9nS++zXu0h2OxyVZPsWfM7dL/9BqdrHkTmr+EDidxFuStsvVMv6gGzrSZu64bkZn7yHa8O/qr7LSkJe9+wdf8gRJhumGCWIEG0NxdANosrpOWhFIU3UH4E+ztgWJPGarDPtbljkKkF8SneBmHzCgJ6F6hxlTns4jXclJxoGwb4FPQUhX3NKYIqah4cShYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGzcmm1zi618cZFCbfkz82L4t6Kd2keQEYqSOrHsS2c=;
 b=Gt5FN8PsznHWRYWZzK7FB6X2cd8aUmfaBS2OXZ/9VATbM99+0821adOtgzz5dX8pi4/G2H8EmY6pbmdmVV8BKTUufq89sHnglc2Fe8VBy4twmKolH9ILIEssqTCVG+UyIm0cqWyyortyS6PnK2+s8UCcktNw04M20njJyA9ZsITAK42PoK1jyiT5mP906MoTLq5LZK+t0CCJOpvhgDyLexGvS0FmVjCyrFOXPrDrN4r9Dmzr1rBI28AZpqiOVYttBzWOe+QXWHNS0YbeYmk1CCSg/2P7WbxsyKTmJHfmNFGWlU94jVjsMu9zma17jR3XIT+FTdI7qj15oJwhSeprWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGzcmm1zi618cZFCbfkz82L4t6Kd2keQEYqSOrHsS2c=;
 b=uiZB5uu84z1vVHSPNCjcdFZV+uRTbzOFVXcEJu/5wruh8F/juD4hgTuBt+OQyeA0LZb1uKfX6kdaviTJmPs/yngZzun9I5J8nktthNynsb0Qk2wjFf84R8MpRS3+YLhb26LW6DEeD8oAlO0N/pUSOR6pTA2c30kJO5geWyBIGmE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4280.eurprd08.prod.outlook.com (2603:10a6:20b:b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 10:27:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 10:27:18 +0000
Subject: Re: [PATCH v3] block/nbd: use non-blocking connect: fix vm hang on
 connect()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200812145237.4396-1-vsementsov@virtuozzo.com>
 <76eefe05-d608-2c1e-252a-361533ea4a0b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9598d3df-4783-d12a-f867-0be4790d0c49@virtuozzo.com>
Date: Thu, 20 Aug 2020 13:27:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <76eefe05-d608-2c1e-252a-361533ea4a0b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:208:ac::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.15 via Frontend Transport; Thu, 20 Aug 2020 10:27:17 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 377e8a4b-761f-4b88-0270-08d844f39d84
X-MS-TrafficTypeDiagnostic: AM6PR08MB4280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42804D6EB6B656203F889251C15A0@AM6PR08MB4280.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kRnGRgZqFI6pMlxF1KnK9zHGMQ0Olzz96+V76KcjRigqrhGGK9B89L4bqFl8mag8RKuEBwNM2G/t6vrSY4N3e+O653L83Em3OZycd6JAtQdnkLhV5nyGISKMpFUKLqU/lX8O5wmXs8ydhdZIA72jhK2HJ9s6JZy0Ws22YeMdxYd8jNxh04lHzd+7rAMTTWYJeNPMmpUZrlPeSRpE3Era22YSXLW3fAUh0wwmLVh/MQ9lGwCJOlOvBNXuj0x4N5Bb+iSu5jbQ9hko8bcoS5aM+L+UGlCMNVhjTgVWAkOfbBdwK71SQSABLrDdSZyPFjqI+B8W4ZjgSAhRZVE77Kn9c4wSp0t0iJ+I6sc24rYcrttf92JVI42CbkWkt6NYpeUPlWy3OpQVBz/lKwYhHNztYzKMHw8sSNtwQASOgdKyrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(478600001)(31696002)(53546011)(316002)(36756003)(83380400001)(52116002)(2616005)(956004)(5660300002)(86362001)(2906002)(8676002)(8936002)(31686004)(186003)(107886003)(4326008)(16576012)(66476007)(16526019)(6486002)(30864003)(26005)(66946007)(66556008)(50194002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: BCsnay6A7HjZ7SZYBilW6worTzjw397HA/HSQvrbc/l7P+zvaFGSn/zCxBDznj2v9i19AS9sWKVNbf+DDleGsVX+cYEk4G2kOwro+xGsEvOZefT8C1tddtOUNYht7wOo0TLrYPv4hYIa7/v3ZCKzXJg28fDMTmr+0wlm+IlUNOL3wm0NRlcAuWW2TVmp1AHhlstnE1UVIJwcfps2/ImIwqltXnNRbNvt1AJntQEa2jq9zkaYUTB/xyig83SiWrHhT2/XcCrC1+i9JfWjbsQy9xWFoqyPCoLiNgnBMUCaVACOvRoIcaoMI6F+TDx769O3je/XBWDDHHD9njzAUsAABKCSjISUuiWF694q78Y52RqsCv6fx4l7iLLAaLpXqKIGiK+tCIeqvy7LDs/3jlCEODtQbDKxXbI4XFRLLwBG3qeIkFkv2NpnESWKJsWK4EBUO8EXVqYhmRv8MeTfmrTc5PE8vP13EZ9X0D4tUPBePKzVL27pY+2z5QRFIXdbKZhek+OtH5ao+zYSriEVRAVlehqkdXslinNi4X5nh6AZ9QJ73pEmyEafDf9myVdqmipi5DZ377HRizUuw3FhqWATyhcFPxvveEQSvhUiqGrtx14acXwYB/kt0xu0PSTKZ2Zv6eQ6whyyeA5gKCZpAfgM9A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377e8a4b-761f-4b88-0270-08d844f39d84
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:27:18.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFdA9+PPL5RkKsqCeHhgkBOywWsKcqgf8IoIB9n8OG0/AwsADYOxBeYcjpuxdhBsx6NQV6DSd9B3RqpyvDXYFCAfwYiCI7Ch5+kc1wkcXmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4280
Received-SPF: pass client-ip=40.107.20.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:27:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 17:46, Eric Blake wrote:
> On 8/12/20 9:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> This make nbd connection_co to yield during reconnects, so that
> 
> s/make nbd connection_co to/makes nbd's connection_co/
> 
>> reconnect doesn't hang up the main thread. This is very important in
> 
> s/hang up/block/
> 
>> case of unavailable nbd server host: connect() call may take a long
> 
> s/of/of an/
> 
>> time, blocking the main thread (and due to reconnect, it will hang
>> again and again with small gaps of working time during pauses between
>> connection attempts).
>>
>> Realization notes:
>>
>>   - We don't want to implement non-blocking connect() over non-blocking
>>   socket, because getaddrinfo() doesn't have portable non-blocking
>>   realization anyway, so let's just use a thread for both getaddrinfo()
>>   and connect().
>>
>>   - We can't use qio_channel_socket_connect_async (which behave
> 
> behaves
> 
>>   similarly and start a thread to execute connect() call), as it's rely
> 
> starts
> relying
> 
>>   on someone iterating main loop (g_main_loop_run() or something like
>>   this), which is not always the case.
>>
>>   - We can't use thread_pool_submit_co API, as thread pool waits for all
>>   threads to finish (but we don't want to wait for blocking reconnect
>>   attempt on shutdown.
>>
>>   So, we just create the thread by hand. Some additional difficulties
>>   are:
>>
>>   - We want our connect don't block drained sections and aio context
> 
> s/don't block/to avoid blocking/
> 
>>   switches. To achieve this, we make it possible to "cancel" synchronous
>>   wait for the connect (which is an coroutine yield actually), still,
> 
> s/an/a/
> 
>>   the thread continues in background, and it successful result may be
> 
> s/it successful/if successful, its/
> 
>>   reused on next reconnect attempt.
>>
>>   - We don't want to wait for reconnect on shutdown, so there is
>>   CONNECT_THREAD_RUNNING_DETACHED thread state, which means that block
>>   layer not more interested in a result, and thread should close new
> 
> which means that the block layer is no longer interested
> 
>>   connected socket on finish and free the state.
>>
>> How to reproduce the bug, fixed with this commit:
>>
>> 1. Create an image on node1:
>>     qemu-img create -f qcow2 xx 100M
>>
>> 2. Start NBD server on node1:
>>     qemu-nbd xx
>>
>> 3. Start vm with second nbd disk on node2, like this:
>>
>>    ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
>>      file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
>>      -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std
>>
>> 4. Access the vm through vnc (or some other way?), and check that NBD
>>     drive works:
>>
>>     dd if=/dev/sdb of=/dev/null bs=1M count=10
>>
>>     - the command should succeed.
>>
>> 5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:
>>
>> 5.1 Kill NBD server on node1
>>
>> 5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
>>      again. The command should fail and a lot of error messages about
>>      failing disk may appear as well.
>>
>>      Now NBD client driver in Qemu tries to reconnect.
>>      Still, VM works well.
>>
>> 6. Make node1 unavailable on NBD port, so connect() from node2 will
>>     last for a long time:
>>
>>     On node1 (Note, that 10809 is just a default NBD port):
>>
>>     sudo iptables -A INPUT -p tcp --dport 10809 -j DROP
>>
>>     After some time the guest hangs, and you may check in gdb that Qemu
>>     hangs in connect() call, issued from the main thread. This is the
>>     BUG.
>>
>> 7. Don't forget to drop iptables rule from your node1:
>>
>>     sudo iptables -D INPUT -p tcp --dport 10809 -j DROP
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi!
>>
>> This a continuation of "[PATCH v2 for-5.1? 0/5] Fix nbd reconnect dead-locks",
>> which was mostly merged to 5.1. The only last patch was not merged, and
>> here is a no-change resend for convenience.
>>
>>
>>   block/nbd.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 265 insertions(+), 1 deletion(-)
> 
> Looks big, but the commit message goes into good detail about what the problem is, why the solution takes the approach it does, and a good formula for reproduction.
> 
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 7bb881fef4..919ec5e573 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -38,6 +38,7 @@
>>   #include "qapi/qapi-visit-sockets.h"
>>   #include "qapi/qmp/qstring.h"
>> +#include "qapi/clone-visitor.h"
>>   #include "block/qdict.h"
>>   #include "block/nbd.h"
>> @@ -62,6 +63,47 @@ typedef enum NBDClientState {
>>       NBD_CLIENT_QUIT
>>   } NBDClientState;
>> +typedef enum NBDConnectThreadState {
>> +/* No thread, no pending results */
>> +    CONNECT_THREAD_NONE,
> 
> I'd indent the comments by four spaces, to line up with the enumeration values they describe.
> 
>> +
>> +/* Thread is running, no results for now */
>> +    CONNECT_THREAD_RUNNING,
>> +
>> +/*
>> + * Thread is running, but requestor exited. Thread should close the new socket
>> + * and free the connect state on exit.
>> + */
>> +    CONNECT_THREAD_RUNNING_DETACHED,
>> +
>> +/* Thread finished, results are stored in a state */
>> +    CONNECT_THREAD_FAIL,
>> +    CONNECT_THREAD_SUCCESS
>> +} NBDConnectThreadState;
>> +
>> +typedef struct NBDConnectThread {
>> +    /* Initialization constants */
>> +    SocketAddress *saddr; /* address to connect to */
>> +    /*
>> +     * Bottom half to schedule on completion. Scheduled only if bh_ctx is not
>> +     * NULL
>> +     */
>> +    QEMUBHFunc *bh_func;
>> +    void *bh_opaque;
>> +
>> +    /*
>> +     * Result of last attempt. Valid in FAIL and SUCCESS states.
>> +     * If you want to steal error, don't forget to set pointer to NULL.
>> +     */
>> +    QIOChannelSocket *sioc;
>> +    Error *err;
>> +
>> +    /* state and bh_ctx are protected by mutex */
>> +    QemuMutex mutex;
>> +    NBDConnectThreadState state; /* current state of the thread */
>> +    AioContext *bh_ctx; /* where to schedule bh (NULL means don't schedule) */
>> +} NBDConnectThread;
> 
> Looks reasonable.
> 
>> @@ -246,6 +298,216 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)
>>       return s->state == NBD_CLIENT_CONNECTING_WAIT;
>>   }
>> +static void connect_bh(void *opaque)
>> +{
>> +    BDRVNBDState *state = opaque;
>> +
>> +    assert(state->wait_connect);
>> +    state->wait_connect = false;
>> +    aio_co_wake(state->connection_co);
>> +}
>> +
>> +static void nbd_init_connect_thread(BDRVNBDState *s)
>> +{
>> +    s->connect_thread = g_new(NBDConnectThread, 1);
>> +
>> +    *s->connect_thread = (NBDConnectThread) {
>> +        .saddr = QAPI_CLONE(SocketAddress, s->saddr),
>> +        .state = CONNECT_THREAD_NONE,
>> +        .bh_func = connect_bh,
>> +        .bh_opaque = s
>> +    };
> 
> I prefer using trailing commas in initializer lists (less churn if a later patch needs to initialize another member)
> 
>> +
>> +    qemu_mutex_init(&s->connect_thread->mutex);
>> +}
>> +
>> +static void nbd_free_connect_thread(NBDConnectThread *thr)
>> +{
>> +    if (thr->sioc) {
>> +        qio_channel_close(QIO_CHANNEL(thr->sioc), NULL);
>> +    }
>> +    error_free(thr->err);
>> +    qapi_free_SocketAddress(thr->saddr);
>> +    g_free(thr);
>> +}
>> +
>> +static void *connect_thread_func(void *opaque)
>> +{
>> +    NBDConnectThread *thr = opaque;
>> +    int ret;
>> +    bool do_free = false;
>> +
>> +    thr->sioc = qio_channel_socket_new();
>> +
>> +    error_free(thr->err);
>> +    thr->err = NULL;
> 
> Why do we need to clear the error at startup?  Shouldn't it already be created as starting life NULL?

Thread lifetime is one connection attempt. On the next connection attempt it will be restarted, so, it should discard previous error.

> 
>> +    ret = qio_channel_socket_connect_sync(thr->sioc, thr->saddr, &thr->err);
>> +    if (ret < 0) {
>> +        object_unref(OBJECT(thr->sioc));
>> +        thr->sioc = NULL;
>> +    }
>> +
>> +    qemu_mutex_lock(&thr->mutex);
>> +
>> +    switch (thr->state) {
>> +    case CONNECT_THREAD_RUNNING:
>> +        thr->state = ret < 0 ? CONNECT_THREAD_FAIL : CONNECT_THREAD_SUCCESS;
>> +        if (thr->bh_ctx) {
>> +            aio_bh_schedule_oneshot(thr->bh_ctx, thr->bh_func, thr->bh_opaque);
>> +
>> +            /* play safe, don't reuse bh_ctx on further connection attempts */
>> +            thr->bh_ctx = NULL;
>> +        }
>> +        break;
>> +    case CONNECT_THREAD_RUNNING_DETACHED:
>> +        do_free = true;
>> +        break;
>> +    default:
>> +        abort();
>> +    }
>> +
>> +    qemu_mutex_unlock(&thr->mutex);
>> +
>> +    if (do_free) {
>> +        nbd_free_connect_thread(thr);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static QIOChannelSocket *coroutine_fn
>> +nbd_co_establish_connection(BlockDriverState *bs, Error **errp)
> 
> There's some inconsistency on whether you use:
> 
> return_type name()
> 
> or
> 
> return_type
> name()
> 
> It's aesthetic, but it would be nice to stick to one (I prefer the second, but see that the qemu code base as a whole is inconsistent, so the best we can do is stay consistent within a file)
> 
>> +{
>> +    QemuThread thread;
>> +    BDRVNBDState *s = bs->opaque;
>> +    QIOChannelSocket *res;
>> +    NBDConnectThread *thr = s->connect_thread;
>> +
>> +    qemu_mutex_lock(&thr->mutex);
> 
> Should we use the auto-cleanup macro magic here? ...
> 
>> +
>> +    switch (thr->state) {
>> +    case CONNECT_THREAD_FAIL:
>> +    case CONNECT_THREAD_NONE:
>> +        error_free(thr->err);
>> +        thr->err = NULL;
>> +        thr->state = CONNECT_THREAD_RUNNING;
>> +        qemu_thread_create(&thread, "nbd-connect",
>> +                           connect_thread_func, thr, QEMU_THREAD_DETACHED);
>> +        break;
>> +    case CONNECT_THREAD_SUCCESS:
>> +        /* Previous attempt finally succeeded in background */
>> +        thr->state = CONNECT_THREAD_NONE;
>> +        res = thr->sioc;
>> +        thr->sioc = NULL;
>> +        qemu_mutex_unlock(&thr->mutex);
>> +        return res;
>> +    case CONNECT_THREAD_RUNNING:
>> +        /* Already running, will wait */
>> +        break;
>> +    default:
>> +        abort();
>> +    }
>> +
>> +    thr->bh_ctx = qemu_get_current_aio_context();
>> +
>> +    qemu_mutex_unlock(&thr->mutex);
>> +
>> +
> 
> ...to do so, you'd put the above in a nested scope, where the mutex is released when the scope is exited.
> 
>> +    /*
>> +     * We are going to wait for connect-thread finish, but
>> +     * nbd_client_co_drain_begin() can interrupt.
>> +     *
>> +     * Note that wait_connect variable is not visible for connect-thread. It
>> +     * doesn't need mutex protection, it used only inside home aio context of
>> +     * bs.
>> +     */
>> +    s->wait_connect = true;
>> +    qemu_coroutine_yield();
>> +
>> +    qemu_mutex_lock(&thr->mutex);
>> +
>> +    switch (thr->state) {
>> +    case CONNECT_THREAD_SUCCESS:
>> +    case CONNECT_THREAD_FAIL:
>> +        thr->state = CONNECT_THREAD_NONE;
>> +        error_propagate(errp, thr->err);
>> +        thr->err = NULL;
>> +        res = thr->sioc;
>> +        thr->sioc = NULL;
>> +        break;
>> +    case CONNECT_THREAD_RUNNING:
>> +    case CONNECT_THREAD_RUNNING_DETACHED:
>> +        /*
>> +         * Obviously, drained section wants to start. Report the attempt as
>> +         * failed. Still connect thread is executing in background, and its
>> +         * result may be used for next connection attempt.
>> +         */
>> +        res = NULL;
>> +        error_setg(errp, "Connection attempt cancelled by other operation");
>> +        break;
>> +
>> +    case CONNECT_THREAD_NONE:
>> +        /*
>> +         * Impossible. We've seen this thread running. So it should be
>> +         * running or at least give some results.
>> +         */
>> +        abort();
>> +
>> +    default:
>> +        abort();
>> +    }
>> +
>> +    qemu_mutex_unlock(&thr->mutex);
>> +
>> +    return res;
>> +}
> 
> Looks sensible.
> 
>> +
>> +/*
>> + * nbd_co_establish_connection_cancel
>> + * Cancel nbd_co_establish_connection asynchronously: it will finish soon, to
>> + * allow drained section to begin.
>> + *
>> + * If detach is true, also cleanup the state (or if thread is running, move it
>> + * to CONNECT_THREAD_RUNNING_DETACHED state). s->connect_thread becomes NULL if
>> + * detach is true.
>> + */
>> +static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
>> +                                               bool detach)
>> +{
>> +    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
> 
> Is the cast necessary here?

No, better to remove it

> 
>> +    NBDConnectThread *thr = s->connect_thread;
>> +    bool wake = false;
>> +    bool do_free = false;
>> +
>> +    qemu_mutex_lock(&thr->mutex);
>> +
>> +    if (thr->state == CONNECT_THREAD_RUNNING) {
>> +        /* We can cancel only in running state, when bh is not yet scheduled */
>> +        thr->bh_ctx = NULL;
>> +        if (s->wait_connect) {
>> +            s->wait_connect = false;
>> +            wake = true;
>> +        }
>> +        if (detach) {
>> +            thr->state = CONNECT_THREAD_RUNNING_DETACHED;
>> +            s->connect_thread = NULL;
>> +        }
>> +    } else if (detach) {
>> +        do_free = true;
>> +    }
>> +
>> +    qemu_mutex_unlock(&thr->mutex);
>> +
>> +    if (do_free) {
>> +        nbd_free_connect_thread(thr);
>> +        s->connect_thread = NULL;
>> +    }
>> +
>> +    if (wake) {
>> +        aio_co_wake(s->connection_co);
>> +    }
>> +}
>> +
>>   static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>>   {
>>       int ret;
>> @@ -289,7 +551,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>>           s->ioc = NULL;
>>       }
>> -    sioc = nbd_establish_connection(s->saddr, &local_err);
>> +    sioc = nbd_co_establish_connection(s->bs, &local_err);
>>       if (!sioc) {
>>           ret = -ECONNREFUSED;
>>           goto out;
>> @@ -1946,6 +2208,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>>       /* successfully connected */
>>       s->state = NBD_CLIENT_CONNECTED;
>> +    nbd_init_connect_thread(s);
>> +
>>       s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
>>       bdrv_inc_in_flight(bs);
>>       aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
>>
> 
> Overall this looks good to me.  I still want to run some tests (including playing with your reproducer formula), but code-wise, I can offer:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> I pointed out a number of grammar and format touchups; I don't mind applying those locally, if there is no other reason to send a v4.
> 

Thanks!

-- 
Best regards,
Vladimir

